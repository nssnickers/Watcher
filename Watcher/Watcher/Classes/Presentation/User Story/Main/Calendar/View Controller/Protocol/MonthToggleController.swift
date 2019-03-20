//
//  MonthToggle.swift
//  Watcher
//
//  Created by Маргарита on 19/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

protocol MonthToggleController: class {
    
    weak var delegate: MonthToggleViewControllerDelegate? { get set }
    
    func update(with monthModel: MonthModel)
}
