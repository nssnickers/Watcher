//
//  Endpoint.swift
//  Watcher
//
//  Created by Маргарита on 18/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

public protocol Endpoint {
    associatedtype Item
    func request() throws -> URLRequest
    func parse(response: Data) throws -> RequestResult<Item>
}
