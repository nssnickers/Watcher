//
//  AuthService.swift
//  Watcher
//
//  Created by Маргарита on 12/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Transport

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
            completion(response)
        }
    }
    
}
