//
//  WeekModel.swift
//  Watcher
//
//  Created by Маргарита on 27/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

struct WeekModel: Codable {
    let fromDate: String
    let toDate: String
    let potentialWorkHour: Double
    let releaseWorkHour: Double
    let monthHourWaitToLog: Double
    let days: [Day]
    
    public init(
        fromDate: String,
        toDate: String,
        potentialWorkHour: Double,
        releaseWorkHour: Double,
        monthHourWaitToLog: Double,
        days: [Day]) {
        self.fromDate = fromDate
        self.toDate = toDate
        self.potentialWorkHour = potentialWorkHour
        self.releaseWorkHour = releaseWorkHour
        self.monthHourWaitToLog = monthHourWaitToLog
        self.days = days
    }
}
