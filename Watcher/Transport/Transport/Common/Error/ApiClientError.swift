//
//  ApiClientError.swift
//  Transport
//
//  Created by Маргарита on 05/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

public enum ApiClientError: Error {
    case invalidParseData(_: Data)
    case invalidSerializationObject(_: Any?)
    case invalidRequest
    case failedAnswer
}
