//
//  AuthViewController.swift
//  Watcher
//
//  Created by Маргарита on 11/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import UIKit

// TODO: вынести константы, избавиться от дублирования

class AuthViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var authService = AuthService()
    private let validator = Validator()
    
    private var activityIndicator = UIActivityIndicatorView(style: .gray)
    private var activeTextField: UITextField?
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var employeLoginButton: UIButton!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var emailErrorLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.5)
        
        employeLoginButton.layer.borderColor = UIColor(named: "pastelOrangeyRed")?.cgColor
        disableLoginButton()
        registerKeyboardNotifications()
    }
    
    
    deinit {
        deRegisterKeyboardNotifications()
    }
    
    
    // MARK: - IBAction
    
    @IBAction private func loginButtonDidTapped(_ sender: Any) {
        activityIndicator.startAnimating()
        self.authService.loginWithEmail(emailTextField.text ?? "", passwordTextField.text ?? "", success: {
            self.activityIndicator.stopAnimating()
            let mainViewController = MainViewController(nibName: nil, bundle: nil)
            self.present(mainViewController, animated: true, completion: nil)
        }, failure: { (error) in
            self.activityIndicator.stopAnimating()
            self.showAlertWithError(error)
        })
    }
    
    
    @IBAction private func fieldEditingChanged(_ sender: Any) {
        let passwordValidation = validator.validateString(self.passwordTextField.text ?? "", for: .password)
        let emailValidation = validator.validateString(self.emailTextField.text ?? "", for: .email)
        switch emailValidation {
        case .success:
            clearEmailError()
        case .error(let errorMessage):
            setEmailError(errorMessage)
        }
        
        if passwordValidation == .success,
            emailValidation == .success {
            enableLoginButton()
        } else {
            disableLoginButton()
        }
    }
    
    
    @IBAction private func beginEditTextField(_ sender: UITextField) {
        activeTextField = sender
    }
    
    
    @IBAction private func endEditTeextField(_ sender: UITextField) {
        activeTextField = nil
    }
    
    
    // MARK: - Private Methods
    
    private func clearEmailError() {
        emailErrorLabel?.text = ""
    }
    
    
    private func setEmailError(_ error: String) {
        emailErrorLabel?.text = error
    }
    
    
    private func enableLoginButton() {
        loginButton?.isEnabled = true
        loginButton.backgroundColor = UIColor(named: "orangeyRed")
    }
    
    
    private func disableLoginButton() {
        loginButton?.isEnabled = false
        loginButton.backgroundColor = UIColor(named: "pastelOrangeyRed")
    }
    
    
    // TODO: вынести
    private func showAlertWithError(_ error: String) {
        let alert = UIAlertController(
            title: NSLocalizedString("Внимание", comment: ""),
            message: error,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ОК", comment: ""), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Keyboard Handling
    
    // TODO: вынести
    fileprivate func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AuthViewController.keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(AuthViewController.keyboardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    
    @objc fileprivate func deRegisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let activeTextField = activeTextField {
            let info: NSDictionary = notification.userInfo! as NSDictionary
            // swiftlint:disable force_cast
            let value: NSValue = info.value(forKey: UIResponder.keyboardFrameBeginUserInfoKey) as! NSValue
            // swiftlint:enable force_cast
            let keyboardSize: CGSize = value.cgRectValue.size
            let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView.contentInset = contentInsets
            scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect: CGRect = self.view.frame
            aRect.size.height -= keyboardSize.height
            let activeTextFieldRect: CGRect? = activeTextField.frame
            let activeTextFieldOrigin: CGPoint? = activeTextFieldRect?.origin
            if !aRect.contains(activeTextFieldOrigin!) {
                scrollView.scrollRectToVisible(activeTextFieldRect!, animated: true)
            }
        }
    }
    
    
    private func keyboardWillHide(notification: NSNotification) {
        let contentInsets: UIEdgeInsets = .zero
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
