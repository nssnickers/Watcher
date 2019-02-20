//
//  KeyboardHandler.swift
//  Watcher
//
//  Created by Маргарита on 17/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import UIKit

protocol KeyboardHandlerDataSource: class {
    func containerScrollView() -> UIScrollView?
    func activeView() -> UIView?
    func superviewFrame() -> CGRect
}

final class KeyboardHandler {
    public weak var delegate: KeyboardHandlerDataSource?
    
    init(withDelegate delegate: KeyboardHandlerDataSource) {
        self.delegate = delegate
    }
    
    
    public func startKeyboardHandling() {
        registerKeyboardNotifications()
    }
    
    
    deinit {
        deRegisterKeyboardNotifications()
    }
    
    
    @objc fileprivate func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardHandler.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(KeyboardHandler.keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc fileprivate func deRegisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let activeView = delegate?.activeView(),
            let scrollView = delegate?.containerScrollView(),
            var aRect: CGRect = delegate?.superviewFrame() {
            
            let info: NSDictionary = notification.userInfo! as NSDictionary
            // swiftlint:disable force_cast
            let value: NSValue = info.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue
            // swiftlint:enable force_cast
            let keyboardSize: CGSize = value.cgRectValue.size
            let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
            aRect.size.height -= keyboardSize.height
            let activeViewRect: CGRect? = activeView.frame
            let activeViewOrigin: CGPoint? = activeViewRect?.origin
            if !aRect.contains(activeViewOrigin!) {
                scrollView.scrollRectToVisible(activeViewRect!, animated: true)
            }
        }
    }
    
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if let scrollView = delegate?.containerScrollView() {
            let contentInsets: UIEdgeInsets = .zero
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
        }
    }
}
