//
//  RealmEntity.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmEntity: Object {
    
    var identifier: String = ""
    
    
    public init(identifier: String) {
        self.identifier = identifier
        super.init()
    }
    
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }
    
    
    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    
    override open class func primaryKey() -> String? {
        return "identifier"
    }
}
