//
//  CookieProperties.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

open class CookieProperties: Entity {
    
    var domain = ""
    var path = ""
    var portList: String?
    var name = ""
    var value = ""
    var version = 0
    var expiresDate: Date?
    var isSessionOnly = true
    var isSecure = false
    var comment: String?
    var commentURL: String?
    
    var date = Date()
    var storageIdentifier = ""
    var url: String?
    var documentUrl: String?
    var taskIdentifier = 0
    
    init(httpCookie cookie: HTTPCookie, identifier: String, storageIdentifier: String) {
        super.init()
        
        self.identifier = identifier
        self.storageIdentifier = storageIdentifier
        
        domain = cookie.domain
        path = cookie.path
        if let portList = cookie.portList {
            self.portList = portList.map({ "\($0)" }).joined(separator: ";")
        }
        
        name = cookie.name
        value = cookie.value
        version = cookie.version
        expiresDate = cookie.expiresDate
        isSessionOnly = cookie.isSessionOnly
        isSecure = cookie.isSecure
        comment = cookie.comment
        commentURL = cookie.commentURL?.absoluteString
    }
    
    required public init() {
        super.init()
    }
    
    func properties() -> [HTTPCookiePropertyKey: Any] {
        var properties: [HTTPCookiePropertyKey: Any] = [:]
        
        properties[.domain] = domain
        properties[.path] = path
        
        if portList != nil {
            properties[.port] = portList
        }
        
        if commentURL != nil {
            properties[.commentURL] = commentURL
        }
        
        if comment != nil {
            properties[.comment] = comment
        }

        properties[.name] = name
        properties[.value] = value
        properties[.version] = version
        properties[.expires] = expiresDate
        properties[.discard] = isSessionOnly ? "TRUE" : "FALSE"
        properties[.secure] = isSecure ? "TRUE" : "FALSE"

        
        return properties
    }
}
