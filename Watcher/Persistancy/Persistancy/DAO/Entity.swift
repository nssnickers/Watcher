//
//  Entity.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

open class Entity: Hashable {
    
    public var identifier = ""
    
    required public init() {}
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    
    public static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
