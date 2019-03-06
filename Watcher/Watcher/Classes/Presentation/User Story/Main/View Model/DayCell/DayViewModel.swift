//
//  DayViewModel.swift
//  Watcher
//
//  Created by Маргарита on 04/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

struct DayViewModel {
    
    public var dayMonthDateLabel: String {
        let date = DateFormatterManager.baseDateFormatter.date(from: day.date)!
        return DateFormatterManager.dayMonthDateFormatter.string(from: date)
    }
    
    public var weekDayLabel: String {
        let date = DateFormatterManager.baseDateFormatter.date(from: day.date)!
        return DateFormatterManager.weekDayLiteralDateFormatter.string(from: date).capitalized
    }
    
    public var remainingHourLabel: String {
        let remainingMinets = day.loggedTimeRecords.reduce(0) { (result, log) -> Int in
            log.minutesSpent + result
        }
        
        let remainingHour = Double(remainingMinets) / 60.0
        
        return String(format: "%.1f", remainingHour) + " ч"
    }
    
    public var isAddLogButtonEnabled: Bool {
        let currentDate = Date()
        let date = DateFormatterManager.baseDateFormatter.date(from: day.date)! //TODO: обработка ошибок
        
        return day.isWorking && date <= currentDate
    }
    
    public var date: String {
        return day.date
    }
    
    public var logModels: [LogViewModel]? {
        return day.loggedTimeRecords.map({ (log) -> LogViewModel in
            return LogViewModel(log: log)
        })
    }
    
    private var day: Day
    
    init(day: Day) {
        self.day = day
    }
}
