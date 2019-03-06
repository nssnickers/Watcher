//
//  LogTimeRange.swift
//  Transport
//
//  Created by Маргарита on 27/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Модель запроса списанных часов в диапазоне
public struct LogTimeRange: Codable {
    
    // MARK: - Public Properties
    
    /// Начало временного диапазона в формате YYYY-MM-DD
    public let from: String
    
    
    /// Конец временного диапазона в формате YYYY-MM-DD
    public let to: String
    
    // MARK: - Public Methods
    
    /// Инициализация диапазона
    ///
    /// - Parameters:
    ///   - from: Начало временного диапазона в формате YYYY-MM-DD
    ///   - to: Конец временного диапазона в формате YYYY-MM-DD
    public init(from: String, to: String) {
        self.from = from
        self.to = to
    }
    
    
    /// Инициализация диапазона
    ///
    /// - Parameters:
    ///   - from: Начало временного диапазона Date
    ///   - to: Конец временного диапазона Date
    public init(from: Date, to: Date) {
        self.from = DateFormatterManager.baseDateFormatter.string(from: from)
        self.to = DateFormatterManager.baseDateFormatter.string(from: to)
    }
}
