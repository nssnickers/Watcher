//
//  RangeViewModel.swift
//  Watcher
//
//  Created by Маргарита on 27/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

struct RangeViewModel {
    
    public var timeRange: String {
        let firstDate = DateFormatterManager.dayDateFormatter.string(from: fromDate)
        let secondDate = DateFormatterManager.dayLiteralMonthDateFormatter.string(from: toDate)

        return "\(firstDate) — \(secondDate)"
    }
    
    public var weekSpentTime: String {
        let hourSpentTime = String(format: "%.1f", spentTime)
        let hourRequiredTime = String(format: "%.1f", requiredTime)
        
        return "\(hourSpentTime) / \(hourRequiredTime)"
    }
    
    public var weekSpentTimePercent: Double {
        return spentTime / requiredTime
    }
    
    public var monthExpectedTime: String {
        return "\(expectedMonthTime) ч не списано в этом месяце" //TODO: локализация
    }

    private let spentTime: Double
    private let requiredTime: Double
    private let expectedMonthTime: Double
    private let fromDate: Date
    private let toDate: Date
    
    init(weekModel: WeekModel) {
        self.spentTime = weekModel.releaseWorkHour
        self.requiredTime = weekModel.potentialWorkHour
        self.expectedMonthTime = weekModel.monthHourWaitToLog
        self.fromDate = DateFormatterManager.baseDateFormatter.date(from: weekModel.fromDate)! //TODO: обработка ошибок
        self.toDate = DateFormatterManager.baseDateFormatter.date(from: weekModel.toDate)!
    }
}
