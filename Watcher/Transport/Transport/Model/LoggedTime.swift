//
//  LoggedTime.swift
//  Watcher
//
//  Created by Маргарита on 19/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation


/// Статус обработки списанных часов
///
/// - pending: в обработке
/// - approved: списано
/// - rejected: отклонено
public enum LoggedTimeStatus: String, Codable {
    case pending
    case approved
    case rejected
}


/// Комментарий к записи о списании часов
public struct LoggedTimeComment: Codable {
    
    /// Комментарий
    public let text: String
    
    /// Время создания
    public let createdAt: String
}


/// Структура
public struct LoggedTime: Codable {
    
    // MARK: - Pulic Properties
    
    /// ID залогированного времени
    public let id: Int
    
    /// ID проекта
    public let projectId: Int
    
    /// ID пользователя
    public let userId: Int?
    
    /// Списанное время в минутах
    public let minutesSpent: Int
    
    /// Проект
    public let project: Project?
    
    /// Дата
    public let date: String
    
    /// Статус обработки списанного времени
    public let status: LoggedTimeStatus
    
    /// Описание
    public let description: String
    
    /// Дата создания лога
    public let createdAt: String
    
    /// Дата последнего обновления
    public let updatedAt: String
    
    /// Массив комментариев
    public let comments: [LoggedTimeComment]?
}
