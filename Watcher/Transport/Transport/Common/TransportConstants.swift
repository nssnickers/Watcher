//
//  TransportConstants.swift
//  Transport
//
//  Created by Маргарита on 22/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Foundation

struct HttpHeaderKey {
    static let contentType = "Content-Type"
    static let setCoookie = "Set-Cookie"
}


struct HttpContentType {
    static let json = "application/json"
}


struct Api {
    struct Url {
        static let scheme = "https"
        
        static let host = "watcher.intern.redmadrobot.com"
        static let path = "/api/v1/"
    }
        
    struct Auth {
        static let outstaff = "auth/sign-in/"
    }
    
    struct WorkTime {
        static let log = "logged-time/"
    }
    
    struct Project {
        static let obtainAll = "projects/"
    }
}
