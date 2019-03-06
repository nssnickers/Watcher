//
//  MainViewController.swift
//  Watcher
//
//  Created by Маргарита on 14/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Transport
import UIKit

/// Главный экран приложения
final class MainViewController: UIViewController {
    
    // MARK: - Public Properties
    
    public var mediatingController = MainMediatingController() //покрыть протоколом, проставлять зависимость
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var dayViewContainer: UIView!
    
    @IBOutlet private weak var weekViewContainer: UIView!
    
    /// MARK: - Private Properties
    
    private var rangeViewController: RangeViewController?
    
    private var weekViewController: WeekCollectionViewController?
    
    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        layout.sectionInset.right = 16
        layout.sectionInset.left = 16
        layout.itemSize = CGSize(width: 332, height: 500)
        layout.sectionFootersPinToVisibleBounds = true
        
        mediatingController.delegate = self
        
        rangeViewController = RangeViewController(nibName: nil, bundle: nil)
        if let weekViewContainer = weekViewContainer,
            let rangeViewController = rangeViewController {
            addChildViewController(rangeViewController, to: weekViewContainer)
            rangeViewController.delegate = self
        }
        
        
        weekViewController = WeekCollectionViewController(collectionViewLayout: layout)
        if let dayViewContainer = dayViewContainer,
            let weekViewController = weekViewController {
            addChildViewController(weekViewController, to: dayViewContainer)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mediatingController.loadWeekForRange()
    }
}


// MARK: - RangeDelegate

extension MainViewController: RangeDelegate {
    
    func loadPreviusWeek() {
        mediatingController.loadPreviusWeek()
    }
    
    
    func loadNextWeek() {
        mediatingController.loadNextWeek()
    }
}


// MARK: - MainMediatingControllerDelegate

extension MainViewController: MainMediatingControllerDelegate {
    
    func startLoadingAnimation() {
        // TODO: реализовать
    }
    
    func stopLoadingAnimation() {
        // TODO: реализовать
    }
    
    func alertWithMessage(_ message: String) {
        // TODO: реализовать
    }
    
    public func updateInterfaceWithWeek(_ week: WeekModel) {
        let rangeVeiwModel = RangeViewModel(weekModel: week)
        rangeViewController?.setupWithModel(rangeVeiwModel)
        
        let dayViewModels = week.days.map({ (day) -> DayViewModel in
            return DayViewModel(day: day)
        })
        weekViewController?.setupWithDays(dayViewModels)
    }
}
