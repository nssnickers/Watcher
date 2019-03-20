//
//  CalendarViewControllerPresenter.swift
//  Watcher
//
//  Created by Маргарита on 19/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

protocol CalendarViewControllerPresenter: MonthToggleViewControllerDelegate, MonthViewControllerDelegate {
    
    func didSelectDate(_ date: Date)
    
    func needUpdate()
    
    func didTapLogButton()
    
}
