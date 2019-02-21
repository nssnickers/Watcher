//
//  PresentationConstants.swift
//  Watcher
//
//  Created by Маргарита on 21/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import UIKit

struct Validation {
    struct ErrorDescription {
        static let shortPassword = NSLocalizedString("Слишком короткий пароль", comment: "")
        static let invalidLogin = NSLocalizedString("Неверный формат логина", comment: "")
    }
    
    struct Rules {
        static let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        static let emailValidationFormat = "SELF MATCHES %@"
        static let passwordMinLength = 6
    }
}

struct Colors {
    static let red = UIColor(named: "orangeyRed")
    static let pastelRed = UIColor(named: "pastelOrangeyRed")
}

struct Alert {
    static let title = NSLocalizedString("Внимание", comment: "")
    static let actionTitle = NSLocalizedString("ОК", comment: "")
}

struct AnimationDuration {
    static let slow = 0.5
}
