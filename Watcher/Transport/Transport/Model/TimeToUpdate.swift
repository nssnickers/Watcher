//
//  TimeToUpdate.swift
//  Transport
//
//  Created by Маргарита on 04/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Структура для сериализации запроса обновления списанного времени
public struct TimeToUpdate: Codable {
    
    /// Потраченные минуты
    let minutesSpent: Int
    
    /// Описание
    let description: String
    
    // MARK: - Public Methods
    
    public init(minutesSpent: Int, description: String) {
        self.minutesSpent = minutesSpent
        self.description = description
    }
}
