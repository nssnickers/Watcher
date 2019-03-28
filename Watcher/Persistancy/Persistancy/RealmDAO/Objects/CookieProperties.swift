//
//  CookieProperties.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

open class CookieProperties: Entity {
    
    public var domain = ""
    public var path = ""
    public var portList: String?
    public var name = ""
    public var value = ""
    public var version = 0
    public var expiresDate: Date?
    public var isSessionOnly = true
    public var isSecure = false
    public var comment: String?
    public var commentURL: String?
    
    public var date = Date()
    public var storageIdentifier = ""
    public var url: String?
    public var documentUrl: String?
    public var taskIdentifier = 0
    
    public init(httpCookie cookie: HTTPCookie, identifier: String, storageIdentifier: String) {
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
    
    public func properties() -> [HTTPCookiePropertyKey: Any] {
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
