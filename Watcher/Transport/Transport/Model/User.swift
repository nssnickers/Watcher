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
    
    /// Имя
    var firstName: String
    
    /// Фамилия
    var lastName: String
    
    /// Роль
    var role: UserRole
    
    /// email
    var email: String
    
    /// ID пользователя
    var id: Int
    
    /// Робот ли или тварь дрожащая
    var isStaff: Bool
}

// MARK: - Equatable

extension User: Equatable {
    
    public static func == (lhs: User, rhs: User) -> Bool {
        let areEqual =
            lhs.id == rhs.id
                && lhs.firstName == rhs.firstName
                && lhs.lastName == rhs.lastName
                && lhs.role == rhs.role
                && lhs.email == rhs.email
                && lhs.isStaff == rhs.isStaff
        
        return areEqual
    }
}
