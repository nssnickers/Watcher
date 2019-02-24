//
//  MainViewController.swift
//  Watcher
//
//  Created by Маргарита on 14/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

/// Главный экран приложения
class MainViewController: UIViewController {

    // MARK: - Lifecycle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - IBAction
    
    @IBAction private func addNewPeriodButtonDidPress(_ sender: Any) {
        let projectsViewController = ProjectsViewController(nibName: nil, bundle: nil)
        present(projectsViewController, animated: true, completion: nil)
    }
    
}
