//
//  TransportConstants.swift
//  Transport
//
//  Created by Маргарита on 22/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

/// Ключи http заголовков
struct HttpHeaderKey {
    
    /// Тип http контента
    static let contentType = "Content-Type"
    
    
    /// Cookie для установки
    static let setCoookie = "Set-Cookie"
    
}


/// Тип http контента
struct HttpContentType {
    
    /// JSON
    static let json = "application/json"
    
}


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
    
    
    /// Запросы на аутентификацию
    struct Auth {
        /// Аутентификация стажеров
        static let outstaff = "auth/sign-in/"
        
    }
    
    
    /// Запросы для работы со списанным временем
    struct WorkTime {
        
        /// Списать часы
        static let log = "logged-time/"
        
    }
    
    
    /// Запросы для работы с проектами
    struct Project {
        
        /// Получить список проектов
        static let obtainAll = "projects/"
    }
}
