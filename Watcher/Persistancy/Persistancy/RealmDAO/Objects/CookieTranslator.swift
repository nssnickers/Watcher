//
//  CookieTranslator.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

open class CookieTranslator: RealmTranslator<CookieRealm, CookieProperties> {
    
    public override init() {
        super.init()
    }
    
    override func getRealmEntityFromEntity(_ entity: CookieProperties) -> CookieRealm {
        let realmCookie = CookieRealm(identifier: entity.identifier)
        
        realmCookie.domain = entity.domain
        realmCookie.path = entity.path
        realmCookie.portList = entity.portList
        realmCookie.name = entity.name
        realmCookie.value = entity.value
        realmCookie.version = entity.version
        realmCookie.expiresDate = entity.expiresDate
        realmCookie.isSessionOnly = entity.isSessionOnly
        realmCookie.isSecure = entity.isSecure
        realmCookie.comment = entity.comment
        realmCookie.commentURL = entity.commentURL
        
        realmCookie.date = entity.date
        realmCookie.storageIdentifier = entity.storageIdentifier
        realmCookie.url = entity.url
        realmCookie.documentUrl = entity.documentUrl
        realmCookie.taskIdentifier = entity.taskIdentifier
        
        return realmCookie
    }
    
    override func getEntityFromRealmEntity(_ realmEntity: CookieRealm) -> CookieProperties {
        
        let cookie = CookieProperties()
        cookie.identifier = realmEntity.identifier
        
        cookie.domain = realmEntity.domain
        cookie.path = realmEntity.path
        cookie.portList = realmEntity.portList
        cookie.name = realmEntity.name
        cookie.value = realmEntity.value
        cookie.version = realmEntity.version
        cookie.expiresDate = realmEntity.expiresDate
        cookie.isSessionOnly = realmEntity.isSessionOnly
        cookie.isSecure = realmEntity.isSecure
        cookie.comment = realmEntity.comment
        cookie.commentURL = realmEntity.commentURL
        
        cookie.date = realmEntity.date
        cookie.storageIdentifier = realmEntity.storageIdentifier
        cookie.url = realmEntity.url
        cookie.documentUrl = realmEntity.documentUrl
        cookie.taskIdentifier = realmEntity.taskIdentifier
        
        return cookie
    }
}
