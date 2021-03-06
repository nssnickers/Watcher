//
//  TimeLogEndpoint.swift
//  Watcher
//
//  Created by Маргарита on 19/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation

struct TimeLogAPIResponse<Content>: Codable where Content: Codable {
    let loggedTime: Content
}

public struct TimeLogEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Item = LoggedTime
    
    // MARK: - Private Properties
    
    private let encoder: JSONEncoder
    
    private let decoder: JSONDecoder
    
    private let timeLog: TimeToLog
    
    
    // MARK: - Initializers
    
    public init(
        timeLog: TimeToLog,
        encoder: JSONEncoder = CodingManager.jsonEncoder,
        decoder: JSONDecoder = CodingManager.jsonDecoder) {
        self.timeLog = timeLog
        self.encoder = encoder
        self.decoder = decoder
    }
    
    
    // MARK: - Public Methods
    
    public func request() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = Api.Url.scheme
        urlComponents.host = Api.Url.host
        urlComponents.path = Api.Url.path
        
        var url = try urlComponents.asURL()
        url.appendPathComponent(Api.WorkTime.log)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let jsonParameters = try encoder.encode(timeLog)
        request.httpBody = jsonParameters
        
        return request
    }
    
    
    public func parse(response: Data) throws -> RequestResult<Item> {
        let decodedResponse = try decoder.decode((APIResponse<TimeLogAPIResponse<Item>>).self, from: response)
        let loggedTime = decodedResponse.data.loggedTime
        
        return .success(loggedTime)
    }
}
