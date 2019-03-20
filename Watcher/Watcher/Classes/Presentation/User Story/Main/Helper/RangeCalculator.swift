//
//  RangeCalculator.swift
//  Watcher
//
//  Created by Маргарита on 06/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

struct RangeCalculator {
    
    private let gregorian = Calendar(identifier: .gregorian)
    
    func getMonthByDate(_ date: Date) -> LogTimeRange {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let startOfMonth = Calendar.current.date(from: components)! //TODO: обработка ошибок
        
        
        var endComponents = DateComponents()
        endComponents.month = 1
        endComponents.day = -1
        let endOfMonth = Calendar.current.date(byAdding: endComponents, to: startOfMonth)! //TODO: обработка ошибок
        
        
        return LogTimeRange(from: startOfMonth, to: endOfMonth)
    }
    
    
    func getWeekByDate(_ date: Date) -> LogTimeRange {
        let sunday = gregorian.date(
            from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))! //TODO: обработка ошибок
        
        let first = gregorian.date(byAdding: .day, value: 1, to: sunday)! //TODO: обработка ошибок
        let last = gregorian.date(byAdding: .day, value: 7, to: sunday)! //TODO: обработка ошибок
        
        return LogTimeRange(from: first, to: last)
    }
    
    
    func getNextWeekByDate(_ date: Date) -> LogTimeRange {
        let currentWeek = getWeekByDate(date)
        let lastDate = DateFormatterManager.baseDateFormatter.date(from: currentWeek.to)! //TODO: обработка ошибок
        let dayNextWeek = gregorian.date(byAdding: .day, value: +2, to: lastDate)! //TODO: обработка ошибок
        
        return getWeekByDate(dayNextWeek)
    }
    
    
    func getPreviusWeekByDate(_ date: Date) -> LogTimeRange {
        let currentWeek = getWeekByDate(date)
        let firstDate = DateFormatterManager.baseDateFormatter.date(from: currentWeek.from)! //TODO: обработка ошибок
        let dayPreviusWeek = gregorian.date(byAdding: .day, value: -2, to: firstDate)! //TODO: обработка ошибок
        
        return getWeekByDate(dayPreviusWeek)
    }
    
    
    func getNextMonthByDate(_ date: Date) -> LogTimeRange {
        let nextMonthDate = gregorian.date(byAdding: .month, value: 1, to: date)! //TODO: обработка ошибок
        
        return getMonthByDate(nextMonthDate)
    }
    
    
    func getPreviusMonthByDate(_ date: Date) -> LogTimeRange {
        let previusMonthDate = gregorian.date(byAdding: .month, value: -1, to: date)! //TODO: обработка ошибок
        
        return getMonthByDate(previusMonthDate)
    }
}
