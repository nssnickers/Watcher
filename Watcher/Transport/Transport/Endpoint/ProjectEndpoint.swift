//
//  ProjectEndpoint.swift
//  Watcher
//
//  Created by Маргарита on 19/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation

public struct ProjectEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Item = [Project]
    
    // MARK: - Private Properties
    
    private let encoder = JSONEncoder()
    
    private let decoder = JSONDecoder()
    
    
    // MARK: - Initializers
    
    public init() {
        encoder.keyEncodingStrategy = .convertToSnakeCase
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    
    // MARK: - Public Methods
    
    public func request() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "watcher.intern.redmadrobot.com"
        urlComponents.path = "/api/v1/projects/"
        
        let url = try urlComponents.asURL()
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        return request
    }
    
    
    public func parse(response: Data) throws -> RequestResult<Item> {
        let decodedResponse = try decoder.decode((APIResponse<Item>).self, from: response)
        let projects = decodedResponse.data["projects"]!
        
        return .success(projects)
    }
}
