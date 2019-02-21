//
//  AuthService.swift
//  Watcher
//
//  Created by Маргарита on 12/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

// TODO: вынести ключи и константы
// TODO: нормальные ошибки


/// Сервис авторизации
final class AuthService {
    
    // MARK: - Private Proerties
    
    private let client = Client()
    
    
    // MARK: - Public Methods
    
    /// Запрос на аутентификацию с логином и паролем
    ///
    /// - Parameters:
    ///   - email: email пользователя
    ///   - password: пароль пользователя
    ///   - completion: блок, который выполняется по завершению запроса
    /// [Ссылка на спецификацию](https://watcher.intern.redmadrobot.com/docs/api.html#operation/signIn)
    public func loginWithEmail(
       _ email: String,
       password: String,
       completion: @escaping (RequestResult<User>) -> Void) {
        
        let authEndpoint = AuthOutstaffEndpoint(outstaffAuth: OutstaffAuth(email: email, password: password))
        
        client.request(with: authEndpoint) { (response) in
//            switch response {
//            case .success(let rawData):
//                let json = rawData.result.value
//                do {
//                    let data = try JSONSerialization.data(withJSONObject: json!)
//
//                    do {
//                        let user = try authEndpoint.parse(response: data)
//
//                        if
//                            let headerFields = rawData.response?.allHeaderFields as? [String: String],
//                            let URL = rawData.request?.url {
//
//                                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
//                                self.client.setCookies(cookies: cookies)
//                        }
//
//                        completion(.success(user))
//                    } catch {
//                        print("Ошибка парсинга JSON: \(data)")
//                        completion(.error(NSLocalizedString("service unavailable", comment: "")))
//                    }
//                } catch {
//                    print("Ошибка сериализации JSON: \(json ?? "")")
//                    completion(.error(NSLocalizedString("service unavailable", comment: "")))
//                }
//            case .error:
//                completion(.error(NSLocalizedString("service unavailable", comment: "")))
//            }
            completion(response)
        }
    }
    
}
