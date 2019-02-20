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
// TODO: сохранять куки авторизации в приложении
// TODO: сделать shared session

/// Клиент для выполнения запросов
public final class Client: ApiClient, EventMonitor {
    
    // MARK: - Public Methods
    
    public init() {}
    
    public func request<Request>(
        with request: Request,
        completionHandler: @escaping CompletionHandler)
        where Request: Endpoint {
        do {
            var httpRequest = try request.request()
            httpRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
            AF.request(httpRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        completionHandler(.success(response))
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        } catch {
            print("Ошибка составления запроса")
        }
    }
    
    
    /// Функция устанавливает cookie для передачи с последующими запросами
    ///
    /// - Parameter cookies: cookie
    public func setCookies(cookies: [HTTPCookie]) {
        let domain = cookies.first?.domain
        Session.default.sessionConfiguration.httpCookieStorage?.setCookies(
            cookies,
            for: URL(fileURLWithPath: domain!),
            mainDocumentURL: URL(fileURLWithPath: domain!))
    }
    
    public func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didFinishCollecting metrics: URLSessionTaskMetrics) {
        print(metrics)
    }
}
