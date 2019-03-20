//
//  WeekDay.swift
//  Watcher
//
//  Created by Маргарита on 19/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

enum WeekDay: String, CaseIterable {
    
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    func localizedString() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
