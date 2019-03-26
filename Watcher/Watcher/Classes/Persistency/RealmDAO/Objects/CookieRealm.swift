//
//  CookieRealm.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class CookieRealm: RealmEntity {
    
    @objc dynamic var storageIdentifier = ""
    @objc dynamic var date = Date()
    @objc dynamic var url: String?
    @objc dynamic var documentUrl: String?
    @objc dynamic var taskIdentifier = 0
    
    @objc dynamic var domain = ""
    @objc dynamic var path = ""
    @objc dynamic var portList: String?
    @objc dynamic var name = ""
    @objc dynamic var value = ""
    @objc dynamic var version = 0
    @objc dynamic var expiresDate: Date?
    @objc dynamic var isSessionOnly = true
    @objc dynamic var isSecure = false
    @objc dynamic var comment: String?
    @objc dynamic var commentURL: String?
    
}
