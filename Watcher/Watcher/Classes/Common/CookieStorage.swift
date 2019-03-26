//
//  CookieStorage.swift
//  Watcher
//
//  Created by Маргарита on 26/03/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

@objc final class CookieStorage: HTTPCookieStorage {
    
    private var identifier = "default"
    
    private static let accessQueue = DispatchQueue(label: "watcher.cookieStorage.queue")
    
    private static var privateShared: CookieStorage?
    
    private static var privateSharedStorages: [String: CookieStorage]?
    
    private let dao = RealmDAO(CookieTranslator())
    
    
    override static var shared: CookieStorage {
        if privateShared == nil {
            accessQueue.sync(flags: .barrier) {
                if privateShared == nil {
                    privateShared = CookieStorage()
                }
            }
        }
        
        return privateShared!
    }
    
    
    override class func sharedCookieStorage(forGroupContainerIdentifier identifier: String) -> HTTPCookieStorage {
        if privateSharedStorages?[identifier] == nil {
            accessQueue.sync(flags: .barrier) {
                if privateSharedStorages?[identifier] == nil {
                    privateSharedStorages?[identifier] = CookieStorage()
                    privateSharedStorages?[identifier]?.identifier = identifier
                }
            }
        }
        
        return privateSharedStorages![identifier]!
    }
    
    
    override var cookies: [HTTPCookie]? {
        do {
            let cookies = try dao.filter("storageIdentifier == \(identifier)")
            return cookies?.map({ (model) -> HTTPCookie in
                return HTTPCookie(properties: model.properties())!
            })
        } catch {
            print("failure to get cookie from storage: \(identifier)")
            return nil
        }
    }
    
    
    override func removeCookies(since date: Date) {
        do {
            let cookies = try dao.filter("date > \(date) && storageIdentifier == \(identifier)")
            
            try cookies?.forEach({ (cookie) in
                try dao.delete(cookie.identifier)
            })
        } catch {
            print("failure to remove cookies since date \(date)")
        }
    }
    
    
    override func deleteCookie(_ cookie: HTTPCookie) {
        do {
            try dao.delete("\(cookie.hash)_\(identifier)")
        } catch {
            print("failure to remove cookie name: \(cookie.name) value: \(cookie.value)")
        }
    }
    
    
    override func setCookie(_ cookie: HTTPCookie) {
        let cookieIdentifier = "\(cookie.hash)_\(identifier)"
        let cookieModel = CookieProperties(
            httpCookie: cookie,
            identifier: cookieIdentifier,
            storageIdentifier: identifier)
        
        do {
            try dao.create(cookieModel)
        } catch {
            print("failure to set cookie name: \(cookie.name) value: \(cookie.value)")
        }
    }
    
    
    override func setCookies(_ cookies: [HTTPCookie], for URL: URL?, mainDocumentURL: URL?) {
        cookies.forEach { (cookie) in
            let cookieIdentifier = "\(cookie.hash)_\(identifier)"
            let model = CookieProperties(
                httpCookie: cookie,
                identifier: cookieIdentifier,
                storageIdentifier: identifier)
            model.url = URL?.absoluteString ?? ""
            model.documentUrl = mainDocumentURL?.absoluteString ?? ""
            
            do {
                try dao.create(model)
            } catch {
                print("failure to set cookie name: \(cookie.name) value: \(cookie.value)")
            }
        }
    }
    
    
    override func storeCookies(_ cookies: [HTTPCookie], for task: URLSessionTask) {
        cookies.forEach { (cookie) in
            let cookieIdentifier = "\(cookie.hash)_\(identifier)"
            let model = CookieProperties(
                httpCookie: cookie,
                identifier: cookieIdentifier,
                storageIdentifier: identifier)
            model.taskIdentifier = task.taskIdentifier
            
            do {
                try dao.create(model)
            } catch {
                print("failure to set cookie name: \(cookie.name) value: \(cookie.value)")
            }
        }
    }
    
    
    override func getCookiesFor(_ task: URLSessionTask, completionHandler: @escaping ([HTTPCookie]?) -> Void) {
        
        var cookies: [HTTPCookie]?
        
        do {
            let filter = "storageIdentifier == \(identifier) && taskIdentifier == \(task.taskIdentifier)"
            let models = try dao.filter(filter)
            cookies = models?.map({ (model) -> HTTPCookie in
                return HTTPCookie(properties: model.properties())!
            })
        } catch {
            print("failure to get cookie from storage: \(identifier) task: \(task.taskIdentifier)")
        }
        
        completionHandler(cookies)
    }
    
    
    override func cookies(for URL: URL) -> [HTTPCookie]? {
        do {
            let cookies = try dao.filter("storageIdentifier == \(identifier) && url == \(URL.absoluteString)")
            return cookies?.map({ (model) -> HTTPCookie in
                return HTTPCookie(properties: model.properties())!
            })
        } catch {
            print("failure to get cookie from storage: \(identifier) url: \(URL.absoluteString)")
            return nil
        }
    }
    
    
    override func sortedCookies(using sortOrder: [NSSortDescriptor]) -> [HTTPCookie] {
        if cookies == nil {
            return []
        }
        
        // swiftlint:disable force_cast
        return (cookies! as NSArray).sortedArray(using: sortOrder) as! [HTTPCookie]
        // swiftlint:enable force_cast
    }
    
}
