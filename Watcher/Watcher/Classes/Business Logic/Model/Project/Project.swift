//
//  Project.swift
//  Watcher
//
//  Created by Маргарита on 14/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Структура, описывающая проекты на которые можно списывать время
struct Project: Codable {
    
    // MARK: - Pulic Properties
    
    var id: Int
    var isCommercial: Bool
    var isArchived: Bool
    var name: String
    var managers: [User]
    
    enum CodingKeys: String, CodingKey {
        case id
        case isCommercial = "is_commercial"
        case isArchived = "is_archived"
        case name
        case managers
    }
}
