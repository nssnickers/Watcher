//
//  OutstaffAuth.swift
//  Watcher
//
//  Created by Маргарита on 19/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Модель аутентификации стажера
public struct OutstaffAuth: Codable {
    
    /// Email
    private let email: String
    
    /// Пароль
    private let password: String
    
    /// Инициализация модели аутентификации стажера
    ///
    /// - Parameters:
    ///   - email: email
    ///   - password: пароль
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
