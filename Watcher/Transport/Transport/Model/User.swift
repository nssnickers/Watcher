//
//  User.swift
//  Watcher
//
//  Created by Маргарита on 11/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Пользовательские роли
///
/// - admin: админ
/// - manager: менеджер
/// - outstaff: стажер
/// - employee: работник
public enum UserRole: String, Codable {
    case admin
    case manager
    case outstaff
    case employee
}

/// Класс пользователя
public struct User: Codable {
    
    // MARK: - Public Properties
    
    var firstName: String
    var lastName: String
    var role: UserRole
    var email: String
    var id: Int
    var isStaff: Bool
}
