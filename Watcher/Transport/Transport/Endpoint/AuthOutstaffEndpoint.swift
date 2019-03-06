//
//  AuthOutstaffEndpoint.swift
//  Watcher
//
//  Created by Маргарита on 18/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation

struct UserAPIResponse<Content>: Codable where Content: Codable {
    let user: Content
}

public struct AuthOutstaffEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Item = User
    
    // MARK: - Private Properties
    
    private let outstaffAuth: OutstaffAuth
    
    private let encoder: JSONEncoder
    
    private let decoder: JSONDecoder
    
    // MARK: - Initializers
    
    public init(
        outstaffAuth: OutstaffAuth,
        encoder: JSONEncoder = CodingManager.jsonEncoder,
        decoder: JSONDecoder = CodingManager.jsonDecoder) {
        self.outstaffAuth = outstaffAuth
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
        url.appendPathComponent(Api.Auth.outstaff)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        
        let jsonParameters = try encoder.encode(outstaffAuth)
        request.httpBody = jsonParameters
        
        return request
    }
    
    
    public func parse(response: Data) throws -> RequestResult<Item> {
        let decodedResponse = try decoder.decode((APIResponse<UserAPIResponse<Item>>).self, from: response)
        let user = decodedResponse.data.user
        
        return .success(user)
    }
}
