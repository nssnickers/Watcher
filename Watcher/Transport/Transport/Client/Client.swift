//
//  Client.swift
//  Watcher
//
//  Created by Маргарита on 11/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire

/// Клиент для выполнения запросов
public final class Client: SessionDelegate, ApiClient {
    
    // MARK: - Private Properties
    
    private var session: Session?
    
    // MARK: - Public Methods
    
    public init() {
        super.init()
        
        let dispatchQueue = DispatchQueue(label: "watcher.alamofire.rootQueue")
        let queue = OperationQueue()
        queue.underlyingQueue = dispatchQueue
        
        let sessionConfiguration = URLSessionConfiguration.ephemeral
        sessionConfiguration.httpCookieStorage = CookieStorage.shared
        
        let urlSession = URLSession(
            configuration: sessionConfiguration,
            delegate: self,
            delegateQueue: queue)
        
        session = Session(
            session: urlSession,
            delegate: self,
            rootQueue: dispatchQueue)
    }
    
    
    override public func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didFinishCollecting metrics: URLSessionTaskMetrics) {
        super.urlSession(session, task: task, didFinishCollecting: metrics)
        
        print(metrics)
    }
    
    
    public func request<Request>(
        with request: Request,
        completionHandler: @escaping (RequestResult<Request.Item>) -> Void )
        where Request: Endpoint {
        
        do {
            var httpRequest = try request.request()
            httpRequest.addValue(HttpContentType.json, forHTTPHeaderField: HttpHeaderKey.contentType)
            session?.request(httpRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: [HttpContentType.json])
                .responseJSON { (response) in
                    switch response.result {
                    case .success:
                        let json = response.result.value
                        do {
                            let data = try JSONSerialization.data(withJSONObject: json!)
                            
                            do {
                                let pointOfInteres = try request.parse(response: data)
                                self.setCookiesIfNeededForResponse(response)
                                completionHandler(pointOfInteres)
                            } catch {
                                completionHandler(.error(ApiClientError.invalidParseData(data)))
                            }
                        } catch {
                            completionHandler(.error(ApiClientError.invalidSerializationObject(json)))
                        }
                    case .failure:
                        // TODO: обработать коды ошибок, обрабатывать сообщения сервера
                        completionHandler(RequestResult.error(ApiClientError.failedAnswer))
                    }
                }
        } catch {
            completionHandler(RequestResult.error(ApiClientError.invalidRequest))
        }
    }
    
    
    // MARK: - Private Methods
    
    private func setCookiesIfNeededForResponse(_ response: DataResponse<Any>) {
        if
            let headerFields = response.response?.allHeaderFields as? [String: String],
            let url = response.request?.url,
            headerFields[HttpHeaderKey.setCoookie] != nil {
            
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: url)
            
            session?.sessionConfiguration.httpCookieStorage?.setCookies(cookies, for: url, mainDocumentURL: url)
        }
    }
}
