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
enum LoggedTimeStatus: String, Codable {
    case pending
    case approved
    case rejected
}


/// Комментарий к записи о списании часов
struct LoggedTimeComment: Codable {
    
    /// Комментарий
    let text: String
    
    /// Время создания
    let createdAt: String
}


/// Структура
public struct LoggedTime: Codable {
    
    // MARK: - Pulic Properties
    
    /// ID залогированного времени
    let id: Int
    
    /// ID проекта
    let projectId: Int
    
    /// ID пользователя
    let userId: Int
    
    /// Списанное время в минутах
    let minutesSpent: Int
    
    /// Проект
    let project: Project
    
    /// Дата
    let date: String
    
    /// Статус обработки списанного времени
    let status: LoggedTimeStatus
    
    /// Описание
    let description: String
    
    /// Дата создания лога
    let createdAt: String
    
    /// Дата последнего обновления
    let updatedAt: String
    
    /// Массив комментариев
    let comments: [LoggedTimeComment]?
}
