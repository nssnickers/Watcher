//
//  Validator.swift
//  Watcher
//
//  Created by Маргарита on 12/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation


/// Тип валидации, который можно применить к строке
///
/// - email: будут применены правила валидации для email
enum ValidationType {
    case email
    case password
}

/// Статус валидации
///
/// - success: успешно
/// - error: ошибка с описанием
enum ValidationResponse: Equatable {
    case success
    case error(String)
}


/// Класс для валидации полей ввода
final class Validator {
    
    // MARK: - Public methods
    
    /// Функция валидирует строку
    ///
    /// - Parameters:
    ///   - string: строка для валидации
    ///   - type: тип валидации, который применяется к полю
    /// - Returns: enum со статусом валидации и описанием ошибки, если валидация не пройдена
    public func validateString(_ string: String, for type: ValidationType) -> ValidationResponse {
        switch type {
        case .email:
            return validateEmail(string)
        case .password:
            return validatePassword(string)
        }
    }
    
    
    // MARK: - Private methods
    
    private func validateEmail(_ email: String) -> ValidationResponse {
        let emailRegEx = Validation.Rules.emailPattern
        let emailValidator = NSPredicate(format: Validation.Rules.emailValidationFormat, emailRegEx)
        
        if !emailValidator.evaluate(with: email) {
            return .error(NSLocalizedString(Validation.ErrorDescription.invalidLogin, comment: ""))
        }
        
        return .success
    }
    
    
    private func validatePassword(_ password: String) -> ValidationResponse {
        
        if password.count <= Validation.Rules.passwordMinLength {
            return .error(NSLocalizedString(Validation.ErrorDescription.shortPassword, comment: ""))
        }
        
        return .success
    }
}
