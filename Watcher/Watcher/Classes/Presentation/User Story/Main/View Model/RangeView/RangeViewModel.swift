//
//  RangeViewModel.swift
//  Watcher
//
//  Created by Маргарита on 27/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

/// Вью модель для описания недели
struct RangeViewModel {
    
    /// Начало - конец недели в формате dd - dd MMMM
    let timeRangeLabel: String
    
    /// Количество списанных и не списанных часов в формате hh/hh
    let weekSpentTimeLabel: String
    
    /// Процент списанных часов от требуемых к списанию
    let weekSpentTimePercent: Double
    
    /// Количество часов, которые нужно списать на данный момент
    let monthExpectedTimeLabel: String
    
    
    // MARK: - Private Properties
    
    private let spentTime: Double
    
    private let requiredTime: Double
    
    private let expectedMonthTime: Double
    
    private let fromDate: Date
    
    private let toDate: Date
    
    // MARK: - Public Methods
    
    init(weekModel: WeekModel) {
        spentTime = weekModel.releaseWorkHour
        requiredTime = weekModel.potentialWorkHour
        expectedMonthTime = weekModel.monthHourWaitToLog
        fromDate = DateFormatterManager.baseDateFormatter.date(from: weekModel.fromDate)! //TODO: обработка ошибок
        toDate = DateFormatterManager.baseDateFormatter.date(from: weekModel.toDate)!
        
        let firstDate = DateFormatterManager.dayDateFormatter.string(from: fromDate)
        let secondDate = DateFormatterManager.dayLiteralMonthDateFormatter.string(from: toDate)
        timeRangeLabel = "\(firstDate) — \(secondDate)"
        
        
        let hourSpentTime = String(format: "%.1f", spentTime)
        let hourRequiredTime = String(format: "%.1f", requiredTime)
        weekSpentTimeLabel = "\(hourSpentTime) / \(hourRequiredTime)"
        
        
        var percent = spentTime / requiredTime
        percent = percent >= 100 ? 100: percent
        weekSpentTimePercent = percent <= 0 ? 0 : percent
        
        
        let expectedHour = expectedMonthTime < 0 ? 0 : expectedMonthTime
        monthExpectedTimeLabel = String(format: "%.1f ч не списано в этом месяце", expectedHour) //TODO: локализация
        
    }
}
