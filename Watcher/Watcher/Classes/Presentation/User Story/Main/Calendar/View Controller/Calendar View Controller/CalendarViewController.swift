//
//  CalendarViewController.swift
//  Watcher
//
//  Created by Маргарита on 15/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Transport
import UIKit


final class CalendarViewController: UIViewController, CalendarController {
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var logTimeButton: UIButton!
    
    @IBOutlet private weak var buttonView: UIView!
    
    @IBOutlet private weak var monthToggleContainerView: UIView!
    
    @IBOutlet private weak var monthContainerView: UIView!
    
    @IBOutlet private weak var buttonViewHeight: NSLayoutConstraint!
    
    // MARK: - Public Properties
    
    public var presenter: CalendarViewControllerPresenter?
    
    // MARK: - Private Properties
    
    private var monthToggleViewController: MonthToggleViewController?
    
    private var monthViewController: MonthViewController?
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupChilds()
        presenter?.needUpdate()
    }
    
    
    // MARK: - Public Methods
    
    func highlightDate(_ date: Date) {
        monthViewController?.highlightDate(date)
    }
    
    
    func unhighlightRange(first: Date, last: Date) {
        monthViewController?.unhighlightRange(first: first, last: last)
        
        hideLogButton()
    }
    
    
    func highlightRange(first: Date, last: Date) {
        monthViewController?.highlightRange(first: first, last: last)
        
        showLogButton()
    }
    
    
    func update(with monthModel: MonthModel) {
        monthToggleViewController?.update(with: monthModel)
        monthViewController?.update(with: monthModel)
    }
    
    func close(animated: Bool, completion: (() -> Void)?) {
        dismiss(animated: animated, completion: completion)
    }
    
    
    // MARK: - IBAction
    
    @IBAction private func logTimeButtonDidTapped(_ sender: Any) {
        presenter?.didTapLogButton()
    }
    
    
    // MARK: - Private Methods
    
    private func setupChilds() {
        
        self.monthViewController = MonthViewController(nibName: nil, bundle: nil)
        if let monthViewController = self.monthViewController,
            let monthContainerView = self.monthContainerView {
            self.addChildViewController(monthViewController, to: monthContainerView)
            self.monthViewController?.delegate = self.presenter
        }
        
        self.monthToggleViewController = MonthToggleViewController(nibName: nil, bundle: nil)
        if let monthToggleViewController = self.monthToggleViewController,
            let monthToggleContainerView = self.monthToggleContainerView {
            self.monthToggleViewController?.delegate = self.presenter
            self.addChildViewController(monthToggleViewController, to: monthToggleContainerView)
        }
    }
    
    
    // TODO: все магические числа вынести 💩
    private func showLogButton() {
        buttonView.transform = CGAffineTransform(scaleX: 0, y: 0)
        let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7) {
            self.buttonViewHeight.constant = 88
            self.view.superview?.superview?.superview?.layoutIfNeeded()
            //TODO: как по-другому? вью не должна знать, какая у нее вложенность 💩
        }
        animator.addCompletion { (_) in
            let secondAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7, animations: {
                self.buttonView.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
            secondAnimator.startAnimation()
        }
        animator.startAnimation()
    }
    
    
    private func hideLogButton() {
        let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7) {
            self.buttonView.transform = CGAffineTransform(scaleX: 0, y: 0)
        }
        animator.addCompletion { (_) in
            let secondAnimator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.7, animations: {
                self.buttonViewHeight.constant = 0
                self.view.superview?.superview?.superview?.layoutIfNeeded()
            })
            secondAnimator.startAnimation()
        }
        animator.startAnimation()
    }
}
