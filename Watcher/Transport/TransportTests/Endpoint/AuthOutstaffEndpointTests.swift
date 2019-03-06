//
//  AuthOutstaffEndpointTests.swift
//  TransportTests
//
//  Created by Маргарита on 20/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
@testable import Transport
import XCTest


class AuthOutstaffEndpointTests: XCTestCase {

    func testAuthRequest() throws {
        //given
        let user = OutstaffAuth(email: "check", password: "pek")
        let endpoint = AuthOutstaffEndpoint(outstaffAuth: user)
        
        //when
        let request = try endpoint.request()
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
            
        //then
        var expectedComponents = URLComponents()
        expectedComponents.scheme = "https"
        expectedComponents.host = "watcher.intern.redmadrobot.com"
        expectedComponents.path = "/api/v1/auth/sign-in/"
        let expectedHttpMethod = HTTPMethod.post
        
        XCTAssertEqual(expectedComponents.scheme, components?.scheme)
        XCTAssertEqual(expectedComponents.host, components?.host)
        XCTAssertEqual(expectedComponents.path, components?.path)
        XCTAssertEqual(request.httpMethod, expectedHttpMethod.rawValue)
    }

}
