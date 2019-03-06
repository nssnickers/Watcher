//
//  ProjectEndpoint.swift
//  Watcher
//
//  Created by Маргарита on 19/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation

struct ProjectsAPIResponse<Content>: Codable where Content: Codable {
    let projects: Content
}

public struct ProjectEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Item = [Project]
    
    // MARK: - Private Properties
    
    private let decoder: JSONDecoder
    
    // MARK: - Initializers
    
    public init(decoder: JSONDecoder = CodingManager.jsonDecoder) {
        self.decoder = decoder
    }
    
    
    // MARK: - Public Methods
    
    public func request() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = Api.Url.scheme
        urlComponents.host = Api.Url.host
        urlComponents.path = Api.Url.path
        
        var url = try urlComponents.asURL()
        url.appendPathComponent(Api.Project.obtainAll)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        return request
    }
    
    
    public func parse(response: Data) throws -> RequestResult<Item> {
        let decodedResponse = try decoder.decode((APIResponse<ProjectsAPIResponse<Item>>).self, from: response)
        let projects = decodedResponse.data.projects
        
        return .success(projects)
    }
}
