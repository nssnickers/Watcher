//
//  AuthOutstaffEndpoint.swift
//  Watcher
//
//  Created by Маргарита on 18/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation

public struct AuthOutstaffEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Item = User
    
    // MARK: - Private Properties
    
    private let outstaffAuth: OutstaffAuth
    
    private let encoder = JSONEncoder()
    
    private let decoder = JSONDecoder()
    
    // MARK: - Initializers
    
    public init(outstaffAuth: OutstaffAuth) {
        self.outstaffAuth = outstaffAuth
        encoder.keyEncodingStrategy = .convertToSnakeCase
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    
    // MARK: - Public Methods
    
    public func request() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "watcher.intern.redmadrobot.com"
        urlComponents.path = "/api/v1/auth/sign-in/"
        
        let url = try urlComponents.asURL()
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let jsonParameters = try encoder.encode(outstaffAuth)
        request.httpBody = jsonParameters
        
        return request
    }
    
    
    public func parse(response: Data) throws -> RequestResult<Item> {
        let decodedResponse = try decoder.decode((APIResponse<Item>).self, from: response)
        let user = decodedResponse.data["user"]!
        
        return .success(user)
    }
}
