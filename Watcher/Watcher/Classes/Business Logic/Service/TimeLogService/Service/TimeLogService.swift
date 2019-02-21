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
            completion?(response)
        }
    }
}
