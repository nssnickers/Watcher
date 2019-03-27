//
//  TimeLogService.swift
//  Watcher
//
//  Created by Маргарита on 18/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

typealias LogTimeCompletion = (RequestResult<LoggedTime>) -> Void
typealias LogTimesCompletion = (RequestResult<[LoggedTime]>) -> Void
typealias ObtainTimeCompletion = (RequestResult<[Day]>) -> Void

final class TimeLogService {
    
    // MARK: - Private Properties
    
    private let client = Client()
    
    
    // MARK: - Public Methods
    
    public func sendTimeLog(_ timeLog: TimeToLog, _ completion: LogTimeCompletion?) {
        let timeLogEndpoint = TimeLogEndpoint(timeLog: timeLog)
        client.request(with: timeLogEndpoint) { (response) in
            completion?(response)
        }
    }
    
    
    public func updateTimeLog(_ timeLog: TimeToUpdate, timeIdentifier: Int, _ completion: LogTimeCompletion?) {
        
        let timeUpdateEndpoint = TimeUpdateEndpoint(timeIdentifier: timeIdentifier, timeToUpdate: timeLog)
        client.request(with: timeUpdateEndpoint) { (response) in
            completion?(response)
        }
    }
    
    
    public func obtainLogForRange(_ range: LogTimeRange?, _ completion: @escaping ObtainTimeCompletion) {
        let weekEndpoint = ObtainLogEndpoint(range: range)
        client.request(with: weekEndpoint) { (response) in
            completion(response)
        }
    }
    
    
    public func sendLogForProjectId(
        _ projectId: Int,
        dates: [String],
        completion: LogTimesCompletion?) {
        
        var error: ApiClientError?
        
        var loggedTime: [LoggedTime] = []
        
        DispatchQueue.global(qos: .background).async {
            let group = DispatchGroup()
            
            dates.forEach { (date) in
                let timeLog = TimeToLog(
                    projectId: projectId,
                    minutesSpent: 60 * 8,
                    date: date,
                    description: "")
                
                let timeLogEndpoint = TimeLogEndpoint(timeLog: timeLog)
                
                group.enter()
                
                self.client.request(with: timeLogEndpoint) { (response) in
                    switch response {
                    case .error(let responseError):
                            error = responseError
                            group.leave()
                    case .success(let time):
                        loggedTime.append(time)
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: .main, execute: {
                if error != nil {
                    completion?(.error(error!))
                } else {
                    completion?(.success(loggedTime))
                }
            })
        }
    }
}
