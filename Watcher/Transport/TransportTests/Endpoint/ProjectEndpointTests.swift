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
    
    // TODO: тут можно создать много юзкейсов, где будут мапиться разные необязательные поля + невалидные
    func testProjectResponse() {
        //given
        let endpoint = ProjectEndpoint()
        let project = Project(
            id: 23,
            isCommercial: true,
            isArchived: false,
            name: "Test Project",
            managers: nil)
        
        let data = APIResponse<[Project]>(data: ["projects": [project]])
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        
        do {
            let raw = try encoder.encode(data)
            
            //when
            do {
                let response = try endpoint.parse(response: raw)
                switch response {
                case .success(let projects):
                    //then
                    let expectedResponse = [project]
                    
                    XCTAssertTrue(projects == expectedResponse, "")
                default:
                    XCTFail("Ошибка парсинга ответа")
                }
                
                
            } catch {
                XCTFail("Не удалось распарсить данные")
            }
        } catch {
            XCTFail("Не удалось кодировать данные")
        }
        
        
        
        
    }
}
