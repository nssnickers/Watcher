//
//  TimeLogEndpointTests.swift
//  TransportTests
//
//  Created by Маргарита on 20/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
@testable import Transport
import XCTest

class TimeLogEndpointTests: XCTestCase {

    func testLoggedTimeRequest() {
        //given
        let timeToLog = TimeLog(projectId: 20, minutesSpent: 20, date: "14-12-2012", description: "my lovely endpoint")
        let endpoint = TimeLogEndpoint(timeLog: timeToLog)
        
        //when
        do {
            let request = try endpoint.request()
            
            
            //then
            // страаашно
            do {
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "watcher.intern.redmadrobot.com"
                urlComponents.path = "/api/v1/logged-time/"
                
                let url = try urlComponents.asURL()
                let encoder = JSONEncoder()
                encoder.keyEncodingStrategy = .convertToSnakeCase
                let expectedBody = try encoder.encode(timeToLog)
                
                do {
                    var expectedRequest = try URLRequest(url: url, method: .post)
                    expectedRequest.httpBody = expectedBody
                    XCTAssertEqual(expectedRequest, request)
                } catch {
                    XCTFail("Ошибка при создании URLRequest списания часов")
                }
                
            } catch {
                XCTFail("Ошибка при создании URL запроса списания часов")
            }
            
        } catch {
            XCTFail("Ошибка создания запроса списания часов")
        }
    }

}
