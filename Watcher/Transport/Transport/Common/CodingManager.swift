//
//  CodingManager.swift
//  Transport
//
//  Created by Маргарита on 27/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation


public struct CodingManager {
    
    public static var jsonEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        return encoder
    }
    
    public static var jsonDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            var date: Date?
            
            if dateString.count == 10 {
                date = DateFormatterManager.baseDateFormatter.date(from: dateString)
            } else if dateString.count == 20 {
                date = DateFormatterManager.dateTimeDateFormatter.date(from: dateString)
            } else {
                date = DateFormatterManager.fullDateTimeDateFormatter.date(from: dateString)
            }
            
            guard let dateValue = date else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Cannot decode date string \(dateString)")
            }
            
            return dateValue
            
        })
        
        return decoder
    }
    
    private init() {}
}
