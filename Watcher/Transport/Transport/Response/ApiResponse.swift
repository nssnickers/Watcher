//
//  ApiResponse.swift
//  Watcher
//
//  Created by Маргарита on 19/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

struct APIResponse<Content>: Decodable where Content: Decodable {
    let data: [String: Content]
}