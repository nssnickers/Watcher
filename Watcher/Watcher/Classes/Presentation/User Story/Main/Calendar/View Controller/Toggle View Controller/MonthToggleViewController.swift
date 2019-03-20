//
//  MonthToggleViewController.swift
//  Watcher
//
//  Created by Маргарита on 15/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

let dayWeekCellReuseIdentidifier = "WeekDayCalendarCellReuseIdentifier"
let dayWeekCellClass             = "WeekDayCalendarCollectionViewCell"


final class MonthToggleViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var monthLabel: UILabel?
    
    @IBOutlet private weak var weekDayCollection: UICollectionView!
    
    // MARK: - Public Properties
    
    public weak var delegate: MonthToggleViewControllerDelegate?
    
    // MARK: - Private Properties
    
    private let days: [WeekDay] = WeekDay.allCases
    
    
    // MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWeekDayCollection()
    }
    
    
    // MARK: - IBAction
    
    @IBAction private func previusMonthButtonTapped(_ sender: Any) {
        delegate?.loadPreviusMonth()
    }
    
    
    @IBAction private func nextMonthButtonTapped(_ sender: Any) {
        delegate?.loadNextMonth()
    }
    
    
    // MARK: - Private Methods
    
    private func setupWeekDayCollection() {
        weekDayCollection.register(
            UINib(nibName: dayWeekCellClass, bundle: nil),
            forCellWithReuseIdentifier: dayWeekCellReuseIdentidifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 53, height: 20)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        weekDayCollection.collectionViewLayout = layout
    }
}


// MARK: - MonthToggle

extension MonthToggleViewController: MonthToggleController {
    
    func update(with monthModel: MonthModel) {
        monthLabel?.text = monthModel.month
    }
}


// MARK: - UICollectionViewDataSource

extension MonthToggleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeekDay.allCases.count
    }
    
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: dayWeekCellReuseIdentidifier,
            for: indexPath) as! WeekDayCalendarCollectionViewCell
        // swiftlint:enable force_cast
        cell.setupWithWeekDay(days[indexPath.item])
        
        return cell
    }
}
