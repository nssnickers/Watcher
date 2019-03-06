//
//  LogCollectionViewCell.swift
//  Watcher
//
//  Created by Маргарита on 03/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

final class LogCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var projectLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    
    public func setupWithLog(_ log: LogViewModel) {
        layer.borderColor = Colors.silver?.cgColor
        
        projectLabel?.text = log.projectNameLabel
        descriptionLabel?.text = log.descriptionLabel
        hourLabel?.text = log.spentHourLabel
    }
}
