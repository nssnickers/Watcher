//
//  ProjectService.swift
//  Watcher
//
//  Created by Маргарита on 14/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

import Alamofire

/// Тип ошибок сервиса для работы с проектами
///
/// - authRequired: нужна аутентификация для выполнения запроса
enum ProjectErrorType: String {
    case authRequired = "Не хватает прав для получения списка проектов"
    case somethingWrong = "Сервис временно недоступен, попробуйте авторизоваться позже."
    
    var localizedString: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}


/// Тип ответа сервера
///
/// - success: запрос выполнен удачно, возвращает массив Project
/// - error: при выполнении запроса произошла ошибка, возвращает тип ошибки
enum ProjectResult {
    case success([Project])
    case error(ProjectErrorType)
}

/// Сервис для работы с сущностью проект
final class ProjectService {
    
    // MARK: - Private Properties
    
    private let client = Client()
    
    // MARK: - Public Methods
    
    /// Метод получает массив объектов Project
    ///
    /// - Parameter completion: блок выполнится после завершения запроса
    /// [Ссылка на спецификацию](https://watcher.intern.redmadrobot.com/docs/api.html#operation/list_projects)
    public func obtainProjectsWithCompletion(_ completion: @escaping (ProjectResult) -> Void) {
        
        client.requestResourceWithPath("/projects/", method: .get, parameters: [:]) { (response) in
            do {
                let json = response.result.value!
                let data = try JSONSerialization.data(withJSONObject: json)

                let decoder = JSONDecoder()
                let projects = try decoder.decode([String: [String: [Project]]].self, from: data)
                completion(.success(projects["data"]!["projects"]!))
            } catch {
                completion(.error(.somethingWrong))
            }
        }
    }
}
