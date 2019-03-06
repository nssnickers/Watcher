//
//  ViewController.swift
//  Watcher
//
//  Created by Маргарита on 01/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public func addChildViewController(_ childController: UIViewController, to viewContainer: UIView) {
        addChild(childController)
        childController.view.frame = CGRect(
            x: 0.0,
            y: 0.0,
            width: viewContainer.frame.size.width,
            height: viewContainer.frame.size.height)
        viewContainer.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    
}
