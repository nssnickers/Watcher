//
//  LogViewModel.swift
//  Watcher
//
//  Created by Маргарита on 04/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

/// Вью модель для залогированного времени
struct LogViewModel {
    
    /// Название проекта
    let projectNameLabel: String
    
    /// Описание
    let descriptionLabel: String
    
    /// Списанные часы
    let spentHourLabel: String
    
    /// айди лога
    let identifier: Int
    
    /// Списанные минуты
    let spentMinutes: Int
    
    
    /// Инициализатор вью модели списанного времени
    ///
    /// - Parameter log: модель списанного времени
    init(log: LoggedTime) {
        projectNameLabel = log.project?.name ?? ""
        
        descriptionLabel = log.description
        
        let spentHour = Double(log.minutesSpent) / 60.0
        spentHourLabel = String(format: "%.1f ч", spentHour)
        
        identifier = log.id
        
        spentMinutes = log.minutesSpent
    }
}
