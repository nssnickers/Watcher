//
//  PresentationConstants.swift
//  Watcher
//
//  Created by Маргарита on 21/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Константы валидации

/// Константы валидации
struct Validation {
    
    /// Описание ошибок валидации
    struct ErrorDescription {
        
        /// Короткий пароль
        static let shortPassword = NSLocalizedString("Слишком короткий пароль", comment: "")
        
        /// Неверный формат логина
        static let invalidLogin = NSLocalizedString("Неверный формат логина", comment: "")
    }
    
    
    /// Правила валидации
    struct Rules {
        
        /// Паттерн валидации email
        static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        /// Формат валидации email
        static let emailValidationFormat = "SELF MATCHES %@"
        
        /// Минимальная длинна пароля
        static let passwordMinLength = 6
    }
}

// MARK: - Цвета

/// Цвета
struct Colors {
    
    /// Красный
    static let red = UIColor(named: "orangeyRed")
    
    /// Приглушенный красный
    static let pastelRed = UIColor(named: "pastelOrangeyRed")
}

// MARK: - Alert

/// Константы для Alert
struct Alert {
    
    /// Заголовок
    static let title = NSLocalizedString("Внимание", comment: "")
    
    /// Название действия
    static let actionTitle = NSLocalizedString("ОК", comment: "")
}

// MARK: - Длительность анимаций

/// Длительность анимаций
struct AnimationDuration {
    static let slow = 0.5
}
