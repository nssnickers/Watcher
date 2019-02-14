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
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var employeLoginButton: UIButton!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var emailErrorLabel: UILabel!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeLoginButton.layer.borderColor = #colorLiteral(red: 1, green: 0.2666666667, blue: 0.2, alpha: 1)
        disableLoginButton()
    }
    
    
    // MARK: - IBAction
    
    @IBAction private func loginButtonDidTapped(_ sender: Any) {
        self.authService.loginWithEmail(emailTextField.text ?? "", passwordTextField.text ?? "", success: {
            // TODO: Перейти на главный экран приложения
        }, failure: { (error) in
            self.showAlertWithError(error)
        })
    }
    
    
    @IBAction func fieldEditingChanged(_ sender: Any) {
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
    
    
    // MARK: - Private Methods
    
    private func clearEmailError() {
        emailErrorLabel?.text = ""
    }
    
    
    private func setEmailError(_ error: String) {
        emailErrorLabel?.text = error
    }
    
    
    private func enableLoginButton() {
        loginButton?.isEnabled = true
        loginButton.backgroundColor = #colorLiteral(red: 1, green: 0.2666666667, blue: 0.2, alpha: 1)
    }
    
    
    private func disableLoginButton() {
        loginButton?.isEnabled = false
        loginButton.backgroundColor = #colorLiteral(red: 1, green: 0.2666666667, blue: 0.2, alpha: 0.2517925942)
    }
    
    
    private func showAlertWithError(_ error: String) {
        let alert = UIAlertController(title: "Внимание", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
