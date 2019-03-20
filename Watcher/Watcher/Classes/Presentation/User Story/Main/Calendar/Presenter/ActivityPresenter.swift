//
//  ActivityInteractor.swift
//  Watcher
//
//  Created by Маргарита on 18/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

final class ActivityPresenter: CalendarPresenter {
    
    private var firstDate: Date?
    private var lastDate: Date?
    
    private let activityIdentifier: Int
    
    init(with activityIdentifier: Int) {
        self.activityIdentifier = activityIdentifier
        super.init()
    }
    
    
    override func didSelectDate(_ date: Date) {
        if firstDate == nil {
            firstDate = date
            viewController?.highlightDate(date)
        } else {
            if lastDate == nil {
                
                if date < firstDate! {
                    lastDate = firstDate
                    firstDate = date
                }
                
                if date > firstDate! {
                    lastDate = date
                }
                
                if let from = firstDate,
                    let to = lastDate {
                    viewController?.highlightRange(first: from, last: to)
                }
            } else {
                
                if let from = firstDate,
                    let to = lastDate {
                    viewController?.unhighlightRange(first: from, last: to)
                }
                
                firstDate = date
                lastDate = nil
                
                viewController?.highlightDate(date)
            }
        }
    }
    
    
    override func didTapLogButton() {
        if let from = firstDate,
            let to = lastDate {
            let range = LogTimeRange(from: from, to: to)
            
            CalendarService().obtainCalendarForRange(range) { (result) in
                switch result {
                case .success(let days):
                    let workDays = days.filter({ (day) -> Bool in
                        day.isWorking == true
                    }).map({ (day) -> String in
                        return day.date
                    })
                    
                    TimeLogService().sendLogForProjectId(
                        self.activityIdentifier,
                        dates: workDays,
                        completion: { (result) in
                        
                            switch result {
                            case .success:
                                self.viewController?.close(animated: true, completion: nil)
                            case .error:
                                print("error") //fixme
                            }
                        })
                case .error:
                    print("error") //fixme
                }
            }
        }
        
    }
}
