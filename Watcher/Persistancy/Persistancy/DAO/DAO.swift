//
//  DAO.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

open class DAO <Model: Entity> {
    
    public func create(_ entity: Model) throws {}
    
    public func read(_ entityId: String) throws -> Model? { return nil }
    
    public func update(_ entity: Model) throws {}
    
    public func delete(_ entityId: String) throws {}
}
