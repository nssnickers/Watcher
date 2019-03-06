//
//  TimeLogServiceMapper.swift
//  Watcher
//
//  Created by Маргарита on 27/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

class TimeLogServiceMapper {
    
    public func mapWeekFromDays(_ days: [Day], monthDays: [Day]) -> WeekModel {
        let currentDate = Date()
        var loggedHour = 0.0
        var potentialHour = 0.0
        
        for day in days {
            if day.isWorking {
                potentialHour += 8
            }
            
            if day.loggedTimeRecords.count > 0 {
                loggedHour += day.loggedTimeRecords.reduce(0.0) { (result, time) -> Double in
                    result + (Double(time.minutesSpent) / 60.0)
                }
            }
        }
        
        let monthWorkHour = monthDays
            .reduce(0) { (result, day) -> Double in
                let date = DateFormatterManager.baseDateFormatter.date(from: day.date)! // TODO: обработать ошибки
                
                return result + (day.isWorking && date <= currentDate ? 8 : 0)
            }
        
        let monthWaitToLogHour = monthDays
            .filter { $0.isWorking }
            .reduce(monthWorkHour) { (result, day) -> Double in
                
                let loggedTime = day.loggedTimeRecords.reduce(0.0, { (result, time) -> Double in
                    result + (Double(time.minutesSpent) / 60.0)
                })
                
                return result - loggedTime
            }
        
        let week = WeekModel(
            fromDate: (days.first?.date)!,
            toDate: (days.last?.date)!,
            potentialWorkHour: potentialHour,
            releaseWorkHour: loggedHour,
            monthHourWaitToLog: monthWaitToLogHour,
            days: days)
        
        return week
    }
}
