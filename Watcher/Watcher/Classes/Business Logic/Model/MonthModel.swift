//
//  MonthModel.swift
//  Watcher
//
//  Created by Маргарита on 17/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

struct MonthModel {
    
    public let days: [CalendarDayModel]
    public let month: String?
    
    init(with days: [CalendarDay]) {
        var calendarDays: [CalendarDayModel] = []
        var month: String?
        
        if let firstDay = days.first?.date,
            let date = DateFormatterManager.baseDateFormatter.date(from: firstDay),
            let day = Calendar(identifier: .gregorian).dateComponents([.weekday], from: date).weekday {
            
            let dayOfWeek = (day + 7 - 2) % 7 + 1
            for _ in 1..<dayOfWeek {
                calendarDays.append(CalendarDayModel())
            }
            
            for day in days {
                calendarDays.append(CalendarDayModel(with: day))
            }
            
            month = DateFormatterManager.monthYearDateFormatter.string(from: date)
        }
        
        self.month = month
        self.days = calendarDays
    }
}
