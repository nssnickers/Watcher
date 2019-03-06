//
//  TimeUpdateEndpoint.swift
//  Transport
//
//  Created by Маргарита on 04/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation

struct TimeUpdateAPIResponse<Content>: Codable where Content: Codable {
    let loggedTime: Content
}

public struct TimeUpdateEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Item = LoggedTime
    
    // MARK: - Private Properties
    
    private let encoder: JSONEncoder
    
    private let decoder: JSONDecoder
    
    private let timeUpdate: TimeToUpdate
    
    private let timeIdentifier: Int
    
    
    // MARK: - Initializers
    
    public init(
        timeIdentifier: Int,
        timeToUpdate: TimeToUpdate,
        encoder: JSONEncoder = CodingManager.jsonEncoder,
        decoder: JSONDecoder = CodingManager.jsonDecoder) {
        self.timeUpdate = timeToUpdate
        self.timeIdentifier = timeIdentifier
        self.encoder = encoder
        self.decoder = decoder
    }
    
    
    // MARK: - Public Methods
    
    public func request() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = Api.Url.scheme
        urlComponents.host = Api.Url.host
        urlComponents.path = Api.Url.path
        
        let path = Api.WorkTime.update.replacingOccurrences(of: Api.Macros.updateTimeId, with: "\(timeIdentifier)")
        
        var url = try urlComponents.asURL()
        url.appendPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.patch.rawValue
        
        let jsonParameters = try encoder.encode(timeUpdate)
        request.httpBody = jsonParameters
        
        return request
    }
    
    
    public func parse(response: Data) throws -> RequestResult<Item> {
        let decodedResponse = try decoder.decode((APIResponse<TimeLogAPIResponse<Item>>).self, from: response)
        let loggedTime = decodedResponse.data.loggedTime
        
        return .success(loggedTime)
    }
}
