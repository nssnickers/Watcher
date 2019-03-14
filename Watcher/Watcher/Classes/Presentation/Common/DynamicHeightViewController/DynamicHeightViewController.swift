//
//  DynamicHeightViewController.swift
//  Watcher
//
//  Created by Маргарита on 10/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

/// Контроллер растягивается относительно размера своего контента, презентующий его контроллер просвечивается
final class DynamicHeightViewController: UIViewController {
    
    // MARK: - Public Properties
    
    /// Контент вью контроллер, определяет поведение и внешний вид контента
    var containerViewController: UIViewController?
    
    override var modalPresentationStyle: UIModalPresentationStyle {
        get {
            return .overCurrentContext
        }
        
        set { }
    }
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChilds()
    }
    
    
    // MARK: - IBAction
    
    @IBAction private func disableAreaDidTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Private Methods
    
    private func setupChilds() {
        if let containerViewController = containerViewController {
            addChildViewController(containerViewController, to: containerView)
        }
    }
}
