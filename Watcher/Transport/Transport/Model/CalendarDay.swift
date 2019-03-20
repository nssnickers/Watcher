//
//  CalendarDay.swift
//  Transport
//
//  Created by Маргарита on 15/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Модель описывает списанные часы по дням
public struct CalendarDay: Codable {
    
    // MARK: - Public Properties
    
    /// Дата в формате YYYY-MM-DD
    public let date: String
    
    /// Признак, рабочий ли день или выходной
    public let isWorking: Bool
}
