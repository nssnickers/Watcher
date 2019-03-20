//
//  CalendarController.swift
//  Watcher
//
//  Created by Маргарита on 19/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

protocol CalendarController: class {
    
    func highlightDate(_ date: Date)
    
    func unhighlightRange(first: Date, last: Date)
    
    func highlightRange(first: Date, last: Date)
    
    func update(with monthModel: MonthModel)
    
    func close(animated: Bool, completion: (() -> Void)?)
}
