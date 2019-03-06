//
//  TimeLog.swift
//  Watcher
//
//  Created by Маргарита on 19/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Структура для сериализации запроса к серверу
public struct TimeToLog: Codable {
    
    /// ID проекта, на который тратилось время
    let projectId: Int
    
    /// Потраченные минуты
    let minutesSpent: Int
    
    /// Дата в формате yyyy-MM-dd
    let date: String
    
    /// Описание
    let description: String
    
    // MARK: - Public Methods
    
    public init(projectId: Int, minutesSpent: Int, date: String, description: String) {
        self.projectId = projectId
        self.minutesSpent = minutesSpent
        self.date = date
        self.description = description
    }
}
