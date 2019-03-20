//
//  TransportConstants.swift
//  Transport
//
//  Created by Маргарита on 22/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

// MARK: - Ключи http заголовков

/// Ключи http заголовков
struct HttpHeaderKey {
    
    /// Тип http контента
    static let contentType = "Content-Type"
    
    
    /// Cookie для установки
    static let setCoookie = "Set-Cookie"
    
}

// MARK: - Тип http контента

/// Тип http контента
struct HttpContentType {
    
    /// JSON
    static let json = "application/json"
    
}

// MARK: - Запросы к серверу

/// Запросы к серверу
struct Api {
    
    /// Базовый URL сервера
    struct Url {
        
        /// Схема
        static let scheme = "https"
        
        /// Хост
        static let host = "watcher.intern.redmadrobot.com"
        
        /// Путь
        static let path = "/api/v1/"
        
    }
    
    struct Macros {
        
        /// Макрос для id списания, которое хотим обновить
        static let updateTimeId = "{logged_time_id}"
    }
    
    
    /// Запросы на аутентификацию
    struct Auth {
        /// Аутентификация стажеров
        static let outstaff = "auth/sign-in/"
        
    }
    
    
    /// Запросы для работы со списанным временем
    struct WorkTime {
        
        /// Списать часы
        static let log = "logged-time/"
        
        /// Обновить часы
        static let update = "logged-time/{logged_time_id}"
        
        /// Получить списанные часы по дням во временном диапазоне
        static let days = "days/"
        
    }
    
    
    /// Запросы для работы с проектами
    struct Project {
        
        /// Получить список проектов
        static let obtainAll = "projects/"
    }
    
    
    /// Запросы для работы с производственным календарем
    struct Calendar {
        
        /// Получить дни производственного календаря из заданного диапазона
        static let obtain = "calendar/"
    }
}
