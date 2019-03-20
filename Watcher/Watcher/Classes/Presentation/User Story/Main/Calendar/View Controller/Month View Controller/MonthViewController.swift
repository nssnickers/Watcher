//
//  MonthViewController.swift
//  Watcher
//
//  Created by Маргарита on 15/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

let dayMonthCellReuseIdentifier = "CalendarDayReuseIdentifier"
let dayMonthCellClass           = "CalendarCellCollectionViewCell"

final class MonthViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var dayCollection: UICollectionView!
    
    @IBOutlet private weak var monthCollectionView: UICollectionView!
    
    // MARK: - Public Properties
    
    weak var delegate: MonthViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private var monthModel: MonthModel?
    
    private var swipeInteractionController: SwipeInteractionController?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDayCollection()
    }
    
    
    // MARK: - Private Methods
    
    private func setupDayCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 53, height: 48)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        dayCollection.collectionViewLayout = layout
        
        dayCollection.register(
            UINib(nibName: dayMonthCellClass, bundle: nil),
            forCellWithReuseIdentifier: dayMonthCellReuseIdentifier)
    }
    
    
    private func getCellByDate(_ date: Date) -> CalendarCellCollectionViewCell? {
        
        guard let days = monthModel?.days else {
            return nil
        }
        
        guard let item = days.firstIndex(where: { (day) -> Bool in
            if let dayString = day.date,
                let dayDate = DateFormatterManager.baseDateFormatter.date(from: dayString) {
                return dayDate == date
            } else {
                return false
            }
        }) else {
            return nil
        }
        
        let indexPath = IndexPath(item: item, section: 0)
        
        // swiftlint:disable force_cast
        return (dayCollection.cellForItem(at: indexPath) as! CalendarCellCollectionViewCell)
        // swiftlint:enable force_cast
    }
    
    
    private func getCellsFromFirstDate(_ firstDate: Date, to lastDate: Date) -> [CalendarCellCollectionViewCell]? {
        
        var cells: [CalendarCellCollectionViewCell]? = []
        
        guard let days = monthModel?.days else {
            return nil
        }
        
        for day in days {
            if let dayString = day.date,
                let dayDate = DateFormatterManager.baseDateFormatter.date(from: dayString),
                dayDate >= firstDate,
                dayDate <= lastDate,
                let cell = getCellByDate(dayDate) {
                cells?.append(cell)
            }
        }
        
        return (cells?.count)! > 0 ? cells : nil
    }
}


// MARK: - Month

extension MonthViewController: MonthController {
    
    func highlightDate(_ date: Date) {
        let cell = getCellByDate(date)
        cell?.highlight()
    }
    
    func unhighlightRange(first: Date, last: Date) {
        let cells = getCellsFromFirstDate(first, to: last)
        cells?.forEach({ (cell) in
            cell.unhighlight()
        })
    }
    
    func highlightRange(first: Date, last: Date) {
        let cells = getCellsFromFirstDate(first, to: last)
        cells?.forEach({ (cell) in
            cell.highlight()
        })
    }
    
    
    func update(with monthModel: MonthModel) {
        self.monthModel = monthModel
        dayCollection.reloadData()
    }
}


// MARK: - UICollectionViewDelegate

extension MonthViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // swiftlint:disable force_cast
        let cell = dayCollection.cellForItem(at: indexPath) as! CalendarCellCollectionViewCell
        // swiftlint:enable force_cast
        if let date = cell.date {
            delegate?.didSelectDate(date)
        }
    }
}


// MARK: - UICollectionViewDataSource

extension MonthViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthModel?.days.count ?? 0
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: dayMonthCellReuseIdentifier,
            for: indexPath) as! CalendarCellCollectionViewCell
        // swiftlint:enable force_cast
        
        if let dayModel = monthModel?.days[indexPath.item] {
            let dayViewModel = CalendarDayViewModel(with: dayModel)
            cell.setup(with: dayViewModel)
        }
        
        return cell
    }
}
