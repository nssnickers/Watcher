//
//  WeekDayCalendarCollectionViewCell.swift
//  Watcher
//
//  Created by Маргарита on 15/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

final class WeekDayCalendarCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var weekDayLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - Public Methods
    
    func setupWithWeekDay(_ weekDay: WeekDay) {
        weekDayLabel.text = weekDay.localizedString()
    }
}
