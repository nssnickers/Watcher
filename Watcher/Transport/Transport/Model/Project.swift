//
//  Project.swift
//  Watcher
//
//  Created by Маргарита on 14/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Структура, описывающая проекты на которые можно списывать время
public struct Project: Codable {
    
    // MARK: - Pulic Properties
    
    public var id: Int
    var isCommercial: Bool
    var isArchived: Bool
    public var name: String
    var managers: [User]?
}
