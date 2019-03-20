//
//  MainMediatingController.swift
//  Watcher
//
//  Created by Маргарита on 06/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

final class MainMediatingController {
    
    // MARK: - Public Properties
    
    public weak var delegate: MainMediatingControllerDelegate?
    
    // MARK: - Private Properties
    
    private var weekStorage = WeekStorage()
    
    private let logService = TimeLogService()
    
    private let weekMapper = TimeLogServiceMapper()
    
    private let rangeCalculator = RangeCalculator()
    
    private var weekModel: WeekModel?
    
    private var range: LogTimeRange?
    
    // MARK: - Public Methods
    
    public func loadWeekForDate(_ date: Date? = Date()) {
        let weekRange = rangeCalculator.getWeekByDate(date!)
        
        loadDataWithWeekRange(weekRange) {
            self.delegate?.selectItemWithDate(date!)
        }
    }
    
    
    public func loadWeekForRange(_ range: LogTimeRange? = nil) {
        loadDataWithWeekRange(range)
    }
    
    
    public func loadPreviusWeek() {
        guard range != nil else {
            return
        }
        
        let first = DateFormatterManager.baseDateFormatter.date(from: range!.from)!
        range = rangeCalculator.getPreviusWeekByDate(first)
        
        loadWeekForRange(range)
    }
    
    
    public func loadNextWeek() {
        guard range != nil else {
            return
        }
        
        let first = DateFormatterManager.baseDateFormatter.date(from: range!.from)!
        range = rangeCalculator.getNextWeekByDate(first)
        
        loadWeekForRange(range)
    }
    
    
    // MARK: - Private Methods
    
    private func loadDataWithWeekRange(_ range: LogTimeRange?, success: (() -> Void)? = nil) {
        let currentDate = Date()
        let monthRange = rangeCalculator.getMonthByDate(currentDate)
        
        var weekRange = range
        if weekRange == nil {
            weekRange = rangeCalculator.getWeekByDate(currentDate)
        }
        
        self.range = weekRange
        
        if self.range != nil,
            let weekFromPersistency = weekStorage.getWeekByRange(self.range!) {
            delegate?.updateInterfaceWithWeek(weekFromPersistency)
        }
        
        delegate?.startLoadingAnimation()
        
        logService.obtainLogForRange(monthRange) { (result) in
            switch result {
            case .success(let monthDays):
                
                self.logService.obtainLogForRange(weekRange, { (result) in
                    switch result {
                    case .success(let weekDays):
                        let weekModel = self.weekMapper.mapWeekFromDays(weekDays, monthDays: monthDays)
                        self.weekStorage.setWeek(weekModel)
                        self.delegate?.updateInterfaceWithWeek(weekModel)
                        
                        if let success = success {
                            success()
                        }
                    case .error:
                        self.delegate?.alertWithMessage("") //TODO: нормальная обработка ошибок
                    }
                })
            case .error:
                self.delegate?.alertWithMessage("") //TODO: нормальная обработка ошибок
            }
        }
    }
}

protocol MainMediatingControllerDelegate: class {
    func updateInterfaceWithWeek(_ week: WeekModel)
    func selectItemWithDate(_ date: Date)
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func alertWithMessage(_ message: String)
}
