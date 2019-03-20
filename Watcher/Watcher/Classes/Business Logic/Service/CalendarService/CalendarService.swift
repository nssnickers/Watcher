//
//  CalendarService.swift
//  Watcher
//
//  Created by Маргарита on 16/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

/// Сервис для работы с производственным календарем
final class CalendarService {
    
    // MARK: - Private Properties
    
    private let client = Client()
    
    // MARK: - Public Methods
    
    /// Метод получает массив объектов CalendarDay
    ///
    /// - Parameter completion: блок выполнится после завершения запроса
    /// [Ссылка на спецификацию](https://watcher.intern.redmadrobot.com/docs/api.html#tag/proizvodstvennyj-kalendar)
    public func obtainCalendarForRange(
        _ range: LogTimeRange,
        with completion: @escaping (RequestResult<[CalendarDay]>) -> Void ) {
        let calendarEndpoint = CalendarEndpoint(range: range)
        client.request(with: calendarEndpoint) { (response) in
            completion(response)
        }
    }
}
