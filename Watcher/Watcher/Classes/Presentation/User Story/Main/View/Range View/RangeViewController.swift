//
//  RangeViewController.swift
//  Watcher
//
//  Created by Маргарита on 27/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

protocol RangeDelegate: class {
    
    func loadPreviusWeek()
    
    
    func loadNextWeek()
}

final class RangeViewController: UIViewController {
    
    @IBOutlet private weak var weekProgressLabel: UILabel!
    @IBOutlet private weak var dateRangeLabel: UILabel!
    @IBOutlet private weak var logProgressView: UIProgressView!
    @IBOutlet private weak var monthProgressWiew: UILabel!
    
    public weak var delegate: RangeDelegate? // может лучше сетапить сразу с моделью и делегат ?
    
    
    public func setupWithModel(_ model: RangeViewModel) {
        weekProgressLabel?.text = model.weekSpentTimeLabel
        dateRangeLabel?.text = model.timeRangeLabel
        logProgressView.progress = Float(model.weekSpentTimePercent)
        monthProgressWiew?.text = model.monthExpectedTimeLabel
    }
    
    
    @IBAction private func previusWeekButtonTapped(_ sender: Any) {
        delegate?.loadPreviusWeek()
    }
    
    
    @IBAction private func nextWeekButtonTapped(_ sender: Any) {
        delegate?.loadNextWeek()
    }
}
