//
//  LogViewModel.swift
//  Watcher
//
//  Created by Маргарита on 04/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

struct LogViewModel {
    
    public var projectNameLabel: String {
        return log.project?.name ?? ""
    }
    
    public var descriptionLabel: String {
        return log.description
    }
    
    public var spentHourLabel: String {
        return "\(Double(log.minutesSpent) / 60.0)" + " ч"
    }
    
    public var identifier: Int {
        return log.id
    }
    
    public var spentMinutes: Int {
        return log.minutesSpent
    }
    
    private var log: LoggedTime
    
    init(log: LoggedTime) {
        self.log = log
    }
}
