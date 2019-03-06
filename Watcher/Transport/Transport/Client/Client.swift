//
//  Client.swift
//  Watcher
//
//  Created by Маргарита on 11/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire

// TODO: вынести в настройки
// TODO: сохранять куки авторизации в приложении
// TODO: сделать shared session

/// Клиент для выполнения запросов
public final class Client: ApiClient {
    
    // MARK: - Public Methods
    
    public init() {}
    
    
    public func request<Request>(
        with request: Request,
        completionHandler: @escaping (RequestResult<Request.Item>) -> Void )
        where Request: Endpoint {
        
        do {
            var httpRequest = try request.request()
            httpRequest.addValue(HttpContentType.json, forHTTPHeaderField: HttpHeaderKey.contentType)
        
            AF.request(httpRequest)
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
            
            Session.default.sessionConfiguration.httpCookieStorage?.setCookies(
                cookies,
                for: url,
                mainDocumentURL: url)
        }
    }
}
