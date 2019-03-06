//
//  WeekLogEndpoint.swift
//  Transport
//
//  Created by Маргарита on 27/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import Foundation

struct ObtainLogAPIResponse<Content>: Codable where Content: Codable {
    let days: Content
}

public struct ObtainLogEndpoint: Endpoint {
    
    // MARK: - Types
    
    public typealias Item = [Day]
    
    // MARK: - Private Properties
    
    private let range: LogTimeRange?
    private let decoder: JSONDecoder
    private let encoder: ParameterEncoder
    
    
    // MARK: - Initializers
    
    public init(
        range: LogTimeRange? = nil,
        decoder: JSONDecoder = CodingManager.jsonDecoder,
        encoder: ParameterEncoder = URLEncodedFormParameterEncoder(destination: .queryString)) {
        self.range = range
        self.decoder = decoder
        self.encoder = encoder
    }
    
    
    // MARK: - Public Methods
    
    public func request() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = Api.Url.scheme
        urlComponents.host = Api.Url.host
        urlComponents.path = Api.Url.path
        
        var url = try urlComponents.asURL()
        url.appendPathComponent(Api.WorkTime.days)
        

        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        if let range = range {
            request = try encoder.encode(range, into: request)
        }
        
        return request
    }
    
    
    public func parse(response: Data) throws -> RequestResult<Item> {
        let decodedResponse = try decoder.decode((APIResponse<ObtainLogAPIResponse<Item>>).self, from: response)
        let days = decodedResponse.data.days
        
        return .success(days)
    }
}
