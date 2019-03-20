//
//  CalendarDayModel.swift
//  Watcher
//
//  Created by Маргарита on 17/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

struct CalendarDayModel {
    let date: String?
    let isWorking: Bool?
    let isEmpty: Bool
    
    init(with day: CalendarDay) {
        self.date = day.date
        self.isWorking = day.isWorking
        self.isEmpty = false
    }
    
    init() {
        self.date = nil
        self.isWorking = nil
        self.isEmpty = true
    }
}
