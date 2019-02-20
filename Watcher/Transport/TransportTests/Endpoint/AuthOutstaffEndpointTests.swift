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

    func testAuthRequest() {
        //given
        let user = OutstaffAuth(email: "check", password: "pek")
        let endpoint = AuthOutstaffEndpoint(outstaffAuth: user)
        
        //when
        do {
            let request = try endpoint.request()
            
            
            //then
            // страаашно
            do {
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "watcher.intern.redmadrobot.com"
                urlComponents.path = "/api/v1/auth/sign-in/"
                
                let url = try urlComponents.asURL()
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                let expectedBody = try encoder.encode(user)
                
                do {
                    var expectedRequest = try URLRequest(url: url, method: .post)
                    expectedRequest.httpBody = expectedBody
                    XCTAssertEqual(expectedRequest, request)
                } catch {
                    XCTFail("Ошибка при создании URLRequest авторизации")
                }
                
            } catch {
                XCTFail("Ошибка при создании URL запроса авторизации")
            }
            
        } catch {
            XCTFail("Ошибка создания запроса авторизации")
        }
    }

}
