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
typealias ObtainTimeCompletion = (RequestResult<[Day]>) -> Void

final class TimeLogService {

    private let client = Client()
    
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
}
