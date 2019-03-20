//
//  DayViewModel.swift
//  Watcher
//
//  Created by Маргарита on 04/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport


/// День недели
struct DayViewModel {
    
    /// Дата в формате "dd.MM"
    let dayMonthDateLabel: String
    
    /// Локализированный день недели
    let weekDayLabel: String
    
    /// Количество списаных часов за эту неделю
    let remainingHourLabel: String
    
    /// Рабочий ли это день
    let isAddLogButtonEnabled: Bool
    
    /// Дата в формате YYYY-MM-DD
    let date: String
    
    /// Модели для отображения списаного времени
    let logModels: [LogViewModel]
    
    
    /// Инициализатор вью модели дня
    ///
    /// - Parameter day: день Day
    init(day: Day) {
        let date = DateFormatterManager.baseDateFormatter.date(from: day.date)!
        
        dayMonthDateLabel = DateFormatterManager.dayMonthDateFormatter.string(from: date)
        weekDayLabel = DateFormatterManager.weekDayLiteralDateFormatter.string(from: date).capitalized
        
        let remainingMinets = day.loggedTimeRecords.reduce(0) { (result, log) -> Int in
            log.minutesSpent + result
        }
        let remainingHour = Double(remainingMinets) / 60.0
        remainingHourLabel = String(format: "%.1f", remainingHour) + " ч"
        
        isAddLogButtonEnabled = day.isWorking && date <= Date()
        
        
        self.date = day.date
        
        logModels = day.loggedTimeRecords.map({ (log) -> LogViewModel in
            return LogViewModel(log: log)
        })
    }
}
