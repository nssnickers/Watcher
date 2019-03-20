//
//  CalendarPresenter.swift
//  Watcher
//
//  Created by Маргарита on 20/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

class CalendarPresenter: CalendarViewControllerPresenter {
    
    private var date: Date?
    
    weak var viewController: CalendarController?
    
    
    func didSelectDate(_ date: Date) {}
    
    
    func didTapLogButton() {}
    
    
    func needUpdate() {
        update()
    }
    
    
    /// Показать следующий месяц
    func loadNextMonth() {
        if date == nil {
            return
        }
        
        let nextMonthRange = RangeCalculator().getNextMonthByDate(date!)
        update(with: nextMonthRange)
    }
    
    
    /// Показать предыдущий месяц
    func loadPreviusMonth() {
        if date == nil {
            return
        }
        
        let prevMonthRange = RangeCalculator().getPreviusMonthByDate(date!)
        update(with: prevMonthRange)
    }
    
    
    // MARK: - Private Methods
    
    private func update(with range: LogTimeRange = RangeCalculator().getMonthByDate(Date())) {
        date = DateFormatterManager.baseDateFormatter.date(from: range.from)
        
        CalendarService().obtainCalendarForRange(range) { (result) in
            switch result {
            case .success(let calendarDays):
                let monthModel = MonthModel(with: calendarDays)
                self.viewController?.update(with: monthModel)
                
            case .error:
                print("error") //todo: контроллер выводит ошибку
            }
        }
    }
}
