//
//  CalendarDayViewModel.swift
//  Watcher
//
//  Created by Маргарита on 15/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import UIKit

final class CalendarDayViewModel {
    
    let dayLabelString: String
    let dayCircleColor: UIColor?
    let dayLabelColor: UIColor?
    let date: Date?

    init(with dayModel: CalendarDayModel) {
        if dayModel.isEmpty {
            dayLabelColor = Colors.white
            dayCircleColor = UIColor.clear
            dayLabelString = ""
            date = nil
        } else {
            
            let dayDate = DateFormatterManager.baseDateFormatter.date(from: dayModel.date!)!
            date = dayDate
            let currentDate = DateFormatterManager.baseDateFormatter.string(from: Date())
            dayLabelString = DateFormatterManager.dayDateFormatter.string(from: dayDate)
            
            let isCurrentDate = dayModel.date! == currentDate ? true : false
            let isWorking = dayModel.isWorking ?? false
            
            
            dayCircleColor = isCurrentDate ? Colors.red : UIColor.clear
            var dayColor = isWorking ? Colors.charcoalGrey : Colors.silver
            dayColor = isCurrentDate ? Colors.white : dayColor
            dayLabelColor = dayColor!
        }
    }
}
