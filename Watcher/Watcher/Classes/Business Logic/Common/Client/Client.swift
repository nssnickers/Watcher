//
//  Client.swift
//  Watcher
//
//  Created by Маргарита on 11/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire

// TODO: вынести в настройки
// TODO: вынести константы
// TODO: думаю, что сервисы ничего не должны знать про Alamofire,
// так что нужно сделать интерфейс менее зависимым от библиотеки
// TODO: создать тип для closure
// TODO: валидация кодов ответа
// TODO: обработка ошибок
// TODO: сохранять куки авторизации в приложении
// TODO: ? нужен (ли) слой, который скроет рест архитектуру

/// Клиент для выполнения запросов
final class Client {
    
    // MARK: - Private Properties
    
    private var serverURL = "https://watcher.intern.redmadrobot.com/api/v1/"

    // MARK: - Public Methods
    
    /// Выполняет запрос ресурса
    ///
    /// - Parameters:
    ///   - path: путь к ресурсу на сервере
    ///   - method: HTTP метод запроса
    ///   - parameters: параметры запроса
    ///   - completion: блок, который выполнится после завершения запроса
    public func requestResourceWithPath(
        _ path: String,
        method: HTTPMethod,
        parameters: Parameters,
        completion: @escaping (DataResponse<Any>) -> Void) {
        let resoursePath = URL(string: "\(serverURL)\(path)")!
        
        var request = URLRequest(url: resoursePath)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            return
        }
        
        AF.request(request).responseJSON { (response) in
            completion(response)
        }
    }
    
    
    /// Функция устанавливает cookie для передачи с последующими запросами
    ///
    /// - Parameter cookies: cookie
    public func setCookies(cookies: [HTTPCookie]) {
        Session.default.sessionConfiguration.httpCookieStorage?.setCookies(
            cookies,
            for: URL(string: serverURL),
            mainDocumentURL: URL(string: serverURL))
    }
}
