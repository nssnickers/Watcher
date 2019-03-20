//
//  MonthController.swift
//  Watcher
//
//  Created by Маргарита on 19/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

protocol MonthController: class {
    
    weak var delegate: MonthViewControllerDelegate? { get set }
    // TODO: предупреждение говорит о том,
    // TODO: что скоро нельзя будет писать вик в протоколах, но как тогда жить с зависимостями?
    
    func update(with monthModel: MonthModel)
    
    func highlightDate(_ date: Date)
    
    func unhighlightRange(first: Date, last: Date)
    
    func highlightRange(first: Date, last: Date)
}
