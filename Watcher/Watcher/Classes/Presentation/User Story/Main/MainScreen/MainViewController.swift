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
        
        setupChilds()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mediatingController.loadWeekForRange()
    }
    
    
    // MARK: - IBAction
    
    
    fileprivate func presentCalendarViewControllerWith(_ presenter: CalendarPresenter) {
        
        let calendarViewController = CalendarViewController(nibName: nil, bundle: nil)
        calendarViewController.presenter = presenter
        
        presenter.viewController = calendarViewController
        
        let dynamicRootController = DynamicHeightViewController(nibName: nil, bundle: nil)
        dynamicRootController.containerViewController = calendarViewController
        present(dynamicRootController, animated: true, completion: nil)
    }
    
    
    @IBAction func vacationDidTapped(_ sender: Any) {
        /// id для отпуска
        let vacationProjectId = 18
        
        let presenter = ActivityPresenter(with: vacationProjectId)
        presentCalendarViewControllerWith(presenter)
        
    }
    
    
    @IBAction func sickDidTapped(_ sender: Any) {
        /// id для болезни
        let sickProjectId = 19
        
        let presenter = ActivityPresenter(with: sickProjectId)
        presentCalendarViewControllerWith(presenter)
    }
    
    
    @IBAction func calendarButtonTapped(_ sender: Any) {
        let presenter = SelectDatePresenter()
        presenter.delegate = self
        
        presentCalendarViewControllerWith(presenter)
    }
    
    
    // MARK: - Private Methods
    
    private func setupChilds() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 12
        layout.scrollDirection = .horizontal
        layout.sectionInset.right = 16
        layout.sectionInset.left = 16
        layout.itemSize = CGSize(width: 332, height: 409)
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
    
    func selectItemWithDate(_ date: Date) {
        weekViewController?.selectItemWithDate(date)
    }
    
    
    func startLoadingAnimation() {
        // TODO: реализовать
    }
    
    
    func stopLoadingAnimation() {
        // TODO: реализовать
    }
    
    
    func alertWithMessage(_ message: String) {
        // TODO: реализовать
    }
    
    
    func updateInterfaceWithWeek(_ week: WeekModel) {
        let rangeVeiwModel = RangeViewModel(weekModel: week)
        rangeViewController?.setupWithModel(rangeVeiwModel)
        
        let dayViewModels = week.days.map({ (day) -> DayViewModel in
            return DayViewModel(day: day)
        })
        weekViewController?.setupWithDays(dayViewModels)
    }
}


extension MainViewController: SelectDatePresenterDelegate {
    
    func selectDate(_ date: Date) {
        mediatingController.loadWeekForDate(date)
    }
}
