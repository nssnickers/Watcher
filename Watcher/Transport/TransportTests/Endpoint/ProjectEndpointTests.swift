//
//  ProjectEndpointTests.swift
//  TransportTests
//
//  Created by Маргарита on 20/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
import XCTest
@testable import Transport

class ProjectEndpointTests: XCTestCase {
    
    func testProjectRequest() {
        //given
        let endpoint = ProjectEndpoint()
        
        //when
        do {
            let request = try endpoint.request()
            
            
            //then
            // страаашно
            do {
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "watcher.intern.redmadrobot.com"
                urlComponents.path = "/api/v1/projects/"
                
                let url = try urlComponents.asURL()
                
                do {
                    let expectedRequest = try URLRequest(url: url, method: .get)
                    XCTAssertEqual(expectedRequest, request)
                } catch {
                    XCTFail("Ошибка при создании URLRequest списка проектов")
                }
                
            } catch {
                XCTFail("Ошибка при создании URL запроса списка проектов")
            }
            
        } catch {
            XCTFail("Ошибка создания запроса списка проектов")
        }
    }
}
