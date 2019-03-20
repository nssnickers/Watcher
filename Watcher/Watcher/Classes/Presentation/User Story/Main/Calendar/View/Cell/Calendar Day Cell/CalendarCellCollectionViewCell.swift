//
//  CalendarCellCollectionViewCell.swift
//  Watcher
//
//  Created by Маргарита on 15/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

class CalendarCellCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    var date: Date?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var dayLabel: UILabel!
    
    // MARK: - Private Properties
    
    private var dayViewModel: CalendarDayViewModel?
    
    // MARK: - Public Methods
    
    public func setup(with dayViewModel: CalendarDayViewModel) {
        self.backgroundColor = UIColor.clear
        self.dayViewModel = dayViewModel
        circleView.backgroundColor = dayViewModel.dayCircleColor
        dayLabel.text = dayViewModel.dayLabelString
        dayLabel.textColor = dayViewModel.dayLabelColor
        date = dayViewModel.date
    }
    
    
    public func highlight() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.dayLabel.textColor = Colors.white
            self.backgroundColor = Colors.cloudyBlue
            self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)

        }
        animator.addCompletion { (_) in
            let secondAnimator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut) {
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            secondAnimator.startAnimation()
        }
        
        animator.startAnimation()
        
    }
    
    
    public func unhighlight() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.dayLabel.textColor = self.dayViewModel?.dayLabelColor
            self.backgroundColor = UIColor.clear
        }
        animator.startAnimation()
    }
}
