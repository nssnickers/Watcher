//
//  DAO.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

class DAO <Model: Entity> {
    
    func create(_ entity: Model) throws {}
    
    func read(_ entityId: String) throws -> Model? { return nil }
    
    func update(_ entity: Model) throws {}
    
    func delete(_ entityId: String) throws {}
}
