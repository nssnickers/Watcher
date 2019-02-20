//
//  TimeLogEndpoint.swift
//  Watcher
//
//  Created by Маргарита on 19/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//
import Alamofire
import Foundation

public struct TimeLogEndpoint: Endpoint {
    public typealias Item = LoggedTime
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let timeLog: TimeLog
    
    public init(timeLog: TimeLog) {
        self.timeLog = timeLog
        encoder.keyEncodingStrategy = .convertToSnakeCase
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    
    public func request() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "watcher.intern.redmadrobot.com"
        urlComponents.path = "/api/v1/logged-time/"
        
        let url = try urlComponents.asURL()
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let jsonParameters = try encoder.encode(timeLog)
        request.httpBody = jsonParameters
        
        return request
    }
    
    
    public func parse(response: Data) throws -> RequestResult<Item> {
        let decodedResponse = try decoder.decode((APIResponse<Item>).self, from: response)
        let loggedTime = decodedResponse.data["loggedTime"]!
        
        return .success(loggedTime)
    }
}
