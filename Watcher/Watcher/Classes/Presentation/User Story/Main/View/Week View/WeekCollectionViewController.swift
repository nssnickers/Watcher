//
//  WeekCollectionViewController.swift
//  Watcher
//
//  Created by Маргарита on 03/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Transport
import UIKit

private let reuseIdentifier = "DayCellIdentifier"
private let dayCollectionViewCell = "DayCollectionViewCell"

class WeekCollectionViewController: UICollectionViewController {
    
    private var days: [DayViewModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.register(
            UINib(nibName: dayCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: reuseIdentifier)

        collectionView?.backgroundColor = Colors.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        if UIScreen.main.traitCollection.forceTouchCapability == .available {
            registerForPreviewing(with: self, sourceView: view)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
    }
    
    
    public func setupWithDays(_ days: [DayViewModel]) {
        self.days = days
        collectionView.reloadData()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let days = days else {
            return 0
        }
        
        return days.count
    }
    
    
    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // swiftlint:disable force_cast
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: reuseIdentifier,
            for: indexPath) as! DayCollectionViewCell
        // swiftlint:enable force_cast
        
        if let day = days?[indexPath.item] {
            let logDataSource = LogDataSource(logs: day.logModels ?? [])
            cell.setupWithDayModel(day, dataSource: logDataSource)
            cell.delegate = self
        }
        
        return cell
    }
}


// MARK: - DayCellDelegate

extension WeekCollectionViewController: DayCellDelegate {
    
    func addLogButtonTappedForDay(_ day: Date) {
        let projectViewController = ProjectsViewController(nibName: nil, bundle: nil)
        projectViewController.date = DateFormatterManager.baseDateFormatter.string(from: day)
        
        self.present(projectViewController, animated: true, completion: nil)
    }
}


// MARK: - UIViewControllerPreviewingDelegate

extension WeekCollectionViewController: UIViewControllerPreviewingDelegate {
    
    public func previewingContext(
        _ previewingContext: UIViewControllerPreviewing,
        viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        let offset = collectionView.contentOffset
        let offsetLocation = CGPoint(x: location.x + offset.x, y: location.y + offset.y)
        
        guard let collectionViewIndexPath = collectionView.indexPathForItem(at: offsetLocation) else {
            return nil
        }
        
        // swiftlint:disable force_cast
        guard let collectionViewCell = collectionView.cellForItem(
            at: collectionViewIndexPath) as! DayCollectionViewCell? else {
            return nil
        }
        // swiftlint:enable force_cast
        
        let collectionViewLocation = collectionView.convert(offsetLocation, to: collectionViewCell)
        
        guard let logItem = collectionViewCell.getLogItemByLocation(collectionViewLocation) else {
            return nil
        }
        
        
        let timeLogViewController = TimeLogViewController(nibName: nil, bundle: nil)
        
        timeLogViewController.preferredContentSize = .zero
        
        if let logModel = days?[collectionViewIndexPath.item].logModels?[logItem] {
            timeLogViewController.logModel = logModel
        }
        
        return timeLogViewController
    }
    
    
    public func previewingContext(
        _ previewingContext: UIViewControllerPreviewing,
        commit viewControllerToCommit: UIViewController) {
        
        self.present(viewControllerToCommit, animated: true, completion: nil)
    }
}
