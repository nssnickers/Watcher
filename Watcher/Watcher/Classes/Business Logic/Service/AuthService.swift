//
//  AuthService.swift
//  Watcher
//
//  Created by Маргарита on 12/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

// TODO: сделать структуру для парсинга ответа сервера
// TODO: вынести ключи и константы
// TODO: вынести настройки клиента из сервиса
// TODO: нормальные ошибки


/// Тип ошибок
///
/// - validation: неверный формат параметров
/// - invalidCredentials: неверный логин или пароль
enum AuthErrorType: String {
    case validation = "Неправильный формат логина"
    case invalidCredentials = "Неверный логин или пароль"
}


/// Сервис авторизации
final class AuthService {
    
    // MARK: - Private Proerties
    
    private var client = Client()
    
    
    // MARK: - Public Methods
    
    public func loginWithEmail(
       _ email: String,
       _ password: String,
       success: @escaping () -> Void,
       failure: @escaping (String) -> Void) {
        let parameters = ["email": email, "password": password]
        client.requestResourceWithPath("auth/sign-in/", method: .post, parameters: parameters) { (response) in
            if let httpStatusCode = response.response?.statusCode {
                switch httpStatusCode {
                case 200:
                    if let
                        headerFields = response.response?.allHeaderFields as? [String: String],
                        let URL = response.request?.url {
                        let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
                        self.client.setCookies(cookies: cookies)
                    }
                    
                    success()
                case 401:
                    failure(AuthErrorType.invalidCredentials.rawValue)
                default:
                    failure(AuthErrorType.validation.rawValue)
                }
            } else {
                failure("Сервис временно недоступен, попробуйте авторизоваться позже.")
            }
        }
    }
    
}
