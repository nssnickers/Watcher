//
//  SwipeInteractionController.swift
//  Watcher
//
//  Created by Маргарита on 18/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import UIKit

final class SwipeInteractionController: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Public Properties
    
    var interactionInProgress = false
    
    // MARK: - Private Properties
    
    private var shouldCompleteTransition = false
    
    private weak var viewController: UIViewController!
    
    // MARK: - Lifecycle
    
    init(viewController: UIViewController, containerView: UIView) {
        super.init()
        self.viewController = viewController
        prepareGestureRecognizer(in: containerView)
    }
    
    
    // MARK: - Private Methods
    
    private func prepareGestureRecognizer(in view: UIView) {
        let gesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(handleGesture(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    
    @objc private func handleGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        // 1
        let translation = gestureRecognizer.translation(in: gestureRecognizer.view!.superview!)
        var progress = (translation.y / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        
        switch gestureRecognizer.state {
            
        // 2
        case .began:
            interactionInProgress = true
        // 3
        case .changed:
            shouldCompleteTransition = progress > 0.5
            update(progress)
            
        // 4
        case .cancelled:
            interactionInProgress = false
            cancel()
            
        // 5
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                viewController.dismiss(animated: true, completion: nil)
                finish()
            } else {
                cancel()
            }
        default:
            break
        }
    }
}
