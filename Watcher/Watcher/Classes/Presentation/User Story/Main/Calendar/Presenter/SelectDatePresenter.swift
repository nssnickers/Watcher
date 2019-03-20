//
//  SelectDateInteractor.swift
//  Watcher
//
//  Created by Маргарита on 18/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

protocol SelectDatePresenterDelegate: class {
    func selectDate(_ date: Date)
}


final class SelectDatePresenter: CalendarPresenter {
    
    weak var delegate: SelectDatePresenterDelegate?
    
    override func didSelectDate(_ date: Date) {
        viewController?.close(animated: true, completion: {
            self.delegate?.selectDate(date)
        })
    }
}
