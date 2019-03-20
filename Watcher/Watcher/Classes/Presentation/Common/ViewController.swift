//
//  ViewController.swift
//  Watcher
//
//  Created by Маргарита on 01/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Расширение отвечает за работу с дочерними контроллерами
extension UIViewController {
    
    // MARK: - Public Methods
    
    /// Добавление дочернего контроллера
    ///
    /// - Parameters:
    ///   - childController: контроллер, который хотим добавить
    ///   - viewContainer: контейнер родительского контроллера, в который хотим добавить дочерний контроллер
    public func addChildViewController(_ childController: UIViewController, to viewContainer: UIView) {
        
        addChild(childController)
        viewContainer.addSubview(childController.view)
        
        childController.view.translatesAutoresizingMaskIntoConstraints = false
        let bottom = childController.view.bottomAnchor.constraint(
            equalTo: viewContainer.bottomAnchor)
        let leading = childController.view.leadingAnchor.constraint(
            equalTo: viewContainer.leadingAnchor)
        let trailing = childController.view.trailingAnchor.constraint(
            equalTo: viewContainer.trailingAnchor)
        let height = childController.view.heightAnchor.constraint(
            equalTo: viewContainer.heightAnchor)
        NSLayoutConstraint.activate([bottom, leading, trailing, height])
        
        childController.didMove(toParent: self)
    }
    
}
