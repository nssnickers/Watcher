//
//  AuthViewController.swift
//  Watcher
//
//  Created by Маргарита on 11/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import UIKit

// TODO: избавиться от дублирования

class AuthViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var authService = AuthService()
    private let validator = Validator()
    
    private var activityIndicator = UIActivityIndicatorView(style: .gray)
    private var activeTextField: UITextField?
    private var keyboardHandler: KeyboardHandler?
    
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
        
        keyboardHandler = KeyboardHandler(withDelegate: self)
        
        employeLoginButton.layer.borderColor = Colors.pastelRed?.cgColor
        disableLoginButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        keyboardHandler?.startKeyboardHandling()
    }
    
    
    override func viewWillLayoutSubviews() {
        activityIndicator.center = CGPoint(x: view.frame.size.width * 0.5, y: view.frame.size.height * 0.5)
    }
    
    
    // MARK: - IBAction
    
    @IBAction private func loginButtonDidTapped(_ sender: Any) {
        activityIndicator.startAnimating()
        
        self.authService.loginWithEmail(
            emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            completion: { (result) in
                self.activityIndicator.stopAnimating()
                switch result {
                case .error:
                    self.showAlertWithError(Alert.serverUnavailable)
                case .success:
                    let mainViewController = MainViewController(nibName: nil, bundle: nil)
                    self.present(mainViewController, animated: true, completion: nil)
                }
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
        loginButton.backgroundColor = Colors.red
    }
    
    
    private func disableLoginButton() {
        loginButton?.isEnabled = false
        loginButton.backgroundColor = Colors.pastelRed
    }
    
    
    // TODO: вынести
    private func showAlertWithError(_ error: String) {
        let alert = UIAlertController(title: Alert.title, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Alert.actionTitle, style: .default, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - KeyboardHandlerDataSource

extension AuthViewController: KeyboardHandlerDataSource {
    func containerScrollView() -> UIScrollView? {
        return scrollView
    }
    
    func activeView() -> UIView? {
        return activeTextField
    }
    
    func superviewFrame() -> CGRect {
        return self.view.frame
    }
}
