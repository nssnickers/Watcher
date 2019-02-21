//
//  ProjectService.swift
//  Watcher
//
//  Created by Маргарита on 14/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation
import Transport

/// Сервис для работы с сущностью проект
final class ProjectService {
    
    // MARK: - Private Properties
    
    private let client = Client()
    
    private let getProjectsEndpoint = ProjectEndpoint()
    
    
    // MARK: - Public Methods
    
    /// Метод получает массив объектов Project
    ///
    /// - Parameter completion: блок выполнится после завершения запроса
    /// [Ссылка на спецификацию](https://watcher.intern.redmadrobot.com/docs/api.html#operation/list_projects)
    public func obtainProjectsWithCompletion(_ completion: @escaping (RequestResult<[Project]>) -> Void) {
        client.request(with: getProjectsEndpoint) { (response) in
//            switch response {
//            case .success(let rawData):
//                let json = rawData.result.value
//                do {
//                    let data = try JSONSerialization.data(withJSONObject: json!)
//
//                    do {
//                        let projects = try self.getProjectsEndpoint.parse(response: data)
//                        completion(projects)
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
