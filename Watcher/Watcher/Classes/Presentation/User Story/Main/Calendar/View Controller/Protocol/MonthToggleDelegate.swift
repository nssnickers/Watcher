//
//  MonthToggleDelegate.swift
//  Watcher
//
//  Created by Маргарита on 19/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

protocol MonthToggleViewControllerDelegate: class {
    
    /// Показать следующий месяц
    func loadNextMonth()
    
    /// Показать предыдущий месяц
    func loadPreviusMonth()
}
