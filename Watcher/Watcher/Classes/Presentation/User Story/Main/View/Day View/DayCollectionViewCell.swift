//
//  DayCollectionViewCell.swift
//  Watcher
//
//  Created by Маргарита on 03/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Transport
import UIKit

private let dayCellReuseIdentifier = "LogCell"
private let dayCellView = "LogCollectionViewCell"

class DayCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var workCollectionView: UICollectionView!
    @IBOutlet private weak var logWorkButton: UIButton!
    @IBOutlet private weak var workHourLabel: UILabel!
    @IBOutlet private weak var weekDayLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    private var day: Date? //нужно ли получать день из датасорса или можно хранить тут ??
    
    public weak var delegate: DayCellDelegate?
    private var workCollectionDataSource: UICollectionViewDataSource?

    
    private func registerWorkCell() {
        workCollectionView?.register(
            UINib(nibName: dayCellView, bundle: nil), forCellWithReuseIdentifier: dayCellReuseIdentifier)
    }
    
    
    @IBAction private func logWorkButtonDidTapped(_ sender: Any) {
        if let delegate = delegate,
            let day = day {
            delegate.addLogButtonTappedForDay(day) // как лучше?
        }
    }
    
    
    public func setupWithDayModel(_ day: DayViewModel, dataSource: UICollectionViewDataSource) {
        self.day = DateFormatterManager.baseDateFormatter.date(from: day.date)
        
        weekDayLabel?.text = day.weekDayLabel
        dateLabel?.text = day.dayMonthDateLabel
        workHourLabel?.text = day.remainingHourLabel
        
        logWorkButton.isUserInteractionEnabled = day.isAddLogButtonEnabled
        logWorkButton.backgroundColor = day.isAddLogButtonEnabled ? Colors.red : Colors.white
        logWorkButton.layer.borderColor = (day.isAddLogButtonEnabled ? Colors.red : Colors.silver)?.cgColor
        logWorkButton.tintColor = day.isAddLogButtonEnabled ? Colors.white : Colors.silver


        registerWorkCell()
        workCollectionDataSource = dataSource // сильная ссылка на датасорс ячеек с логами времени, как лучше сделать?
        workCollectionView.dataSource = dataSource
        workCollectionView.reloadData()
    }
    
    
    public func getLogItemByLocation(_ location: CGPoint) -> Int? {
        let collectionLocation = self.convert(location, to: workCollectionView)
        guard let collectionViewIndexPath = workCollectionView.indexPathForItem(at: collectionLocation) else {
            return nil
        }
        
        return collectionViewIndexPath.item
    }
}


// MARK: - DayCellDelegate

protocol DayCellDelegate: class {
    func addLogButtonTappedForDay(_ day: Date)
}
