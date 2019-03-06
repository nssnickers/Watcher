//
//  Project.swift
//  Watcher
//
//  Created by Маргарита on 14/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Структура, описывающая проекты компании
public struct Project: Codable {
    // MARK: - Pulic Properties
    
    /// ID
    public var id: Int
    
    /// За деньги?
    public var isCommercial: Bool
    
    /// В архиве?
    public var isArchived: Bool
    
    /// Имя
    public var name: String
    
    /// Массив менеджеров проекта
    public var managers: [User]?
}

// MARK: - Equatable

extension Project: Equatable {
    
    public static func == (lhs: Project, rhs: Project) -> Bool {
        let areEqual =
            lhs.id == rhs.id
            && lhs.isArchived == rhs.isArchived
            && lhs.isCommercial == rhs.isCommercial
            && lhs.name == rhs.name
            && lhs.managers == rhs.managers
        
        return areEqual
    }
}
