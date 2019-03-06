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
    
    public func loadWeekForRange(_ range: LogTimeRange? = nil) {
        let currentDate = Date()
        let monthRange = rangeCalculator.getMonthByDate(currentDate)
        
        if range != nil {
            self.range = range
        } else {
            self.range = rangeCalculator.getWeekByDate(currentDate)
        }
        
        if self.range != nil,
            let weekFromPersistency = weekStorage.getWeekByRange(self.range!) {
            delegate?.updateInterfaceWithWeek(weekFromPersistency)
        }
        
        delegate?.startLoadingAnimation()
        
        logService.obtainLogForRange(monthRange) { (result) in
            switch result {
            case .success(let monthDays):
                
                self.logService.obtainLogForRange(range, { (result) in
                    switch result {
                    case .success(let weekDays):
                        let weekModel = self.weekMapper.mapWeekFromDays(weekDays, monthDays: monthDays)
                        self.delegate?.updateInterfaceWithWeek(weekModel)
                    case .error:
                        self.delegate?.alertWithMessage("") //TODO: нормальная обработка ошибок
                    }
                })
            case .error:
                self.delegate?.alertWithMessage("") //TODO: нормальная обработка ошибок
            }
        }
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
}

protocol MainMediatingControllerDelegate: class {
    func updateInterfaceWithWeek(_ week: WeekModel)
    func startLoadingAnimation()
    func stopLoadingAnimation()
    func alertWithMessage(_ message: String)
}