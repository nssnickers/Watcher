//
//  ApiClient.swift
//  Watcher
//
//  Created by Маргарита on 18/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation

public typealias CompletionHandler = (RequestResult<DataResponse<Any>>) -> Void

// TODO: подумать над неймингом
/// Декодированный ответ API
///
/// - success: удачно, вернуть контент
/// - error: неудачно, вернуть ошибку
public enum RequestResult<Content> {
    case success(Content)
    case error(String)
}

public protocol ApiClient {
    /// Запрос к серверу
    ///
    /// - Parameters:
    ///   - request: запрос
    ///   - completionHandler: блок выполнится по завершению запроса
    func request<Request>(
        with request: Request,
        completionHandler: @escaping CompletionHandler
        ) where Request: Endpoint
}
