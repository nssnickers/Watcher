//
//  TimeLogService.swift
//  Watcher
//
//  Created by Маргарита on 18/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation
import Transport

typealias LogTimeCompletion = (RequestResult<LoggedTime>) -> Void

final class TimeLogService {

    private let client = Client()
    
    public func sendTimeLog(_ timeLog: TimeLog, _ completion: LogTimeCompletion?) {
        let timeLogEndpoint = TimeLogEndpoint(timeLog: timeLog)
        client.request(with: timeLogEndpoint) { (response) in
            switch response {
            case .success(let rawData):
                let json = rawData.result.value
                do {
                    let data = try JSONSerialization.data(withJSONObject: json!)
                    
                    do {
                        let loggedTime = try timeLogEndpoint.parse(response: data)
                        completion?(loggedTime)
                    } catch {
                        print("Ошибка парсинга JSON: \(data)")
                        completion?(.error(NSLocalizedString("service unavailable", comment: "")))
                    }
                } catch {
                    print("Ошибка сериализации JSON: \(json ?? "")")
                    completion?(.error(NSLocalizedString("service unavailable", comment: "")))
                }
            case .error:
                completion?(.error(NSLocalizedString("service unavailable", comment: "")))
            }
        }
    }
}
