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

open class RealmEntity: Object {
    
    @objc dynamic open var identifier: String = ""
    
    
    public init(identifier: String) {
        self.identifier = identifier
        super.init()
    }
    
    
    required public init() {
        self.identifier = ""
        super.init()
    }
    
    
    required public init(realm: RLMRealm, schema: RLMObjectSchema) {
        self.identifier = ""
        super.init(realm: realm, schema: schema)
    }
    
    
    required public init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }
    
    
    override open class func primaryKey() -> String? {
        return "identifier"
    }
    
}
