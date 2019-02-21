//
//  PresentationConstants.swift
//  Watcher
//
//  Created by Маргарита on 21/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

struct Validation {
    struct ErrorDescription {
        static let shortPassword = "Слишком короткий пароль"
        static let invalidLogin = "Неверный формат логина"
    }
    
    struct Rules {
        static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let emailValidationFormat = "SELF MATCHES %@"
        static let passwordMinLength = 6
    }
}
