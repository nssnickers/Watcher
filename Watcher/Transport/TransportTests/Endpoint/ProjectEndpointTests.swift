//
//  ProjectEndpointTests.swift
//  TransportTests
//
//  Created by Маргарита on 20/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import Alamofire
@testable import Transport
import XCTest

class ProjectEndpointTests: XCTestCase {
    
    func testProjectRequest() throws {
        //given
        let endpoint = ProjectEndpoint()
        
        //when
        let request = try endpoint.request()
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
            
        //then
        var expectedComponents = URLComponents()
        expectedComponents.scheme = "https"
        expectedComponents.host = "watcher.intern.redmadrobot.com"
        expectedComponents.path = "/api/v1/projects/"
        let expectedHttpMethod = HTTPMethod.get
        
        XCTAssertEqual(expectedComponents.scheme, components?.scheme)
        XCTAssertEqual(expectedComponents.host, components?.host)
        XCTAssertEqual(expectedComponents.path, components?.path)
        XCTAssertEqual(request.httpMethod, expectedHttpMethod.rawValue)
        
    }
    
    // TODO: тут можно создать много юзкейсов, где будут мапиться разные необязательные поля + невалидные
    func testProjectResponse() throws {
        //given
        let endpoint = ProjectEndpoint()
        let project = Project(
            id: 23,
            isCommercial: true,
            isArchived: false,
            name: "Test Project",
            managers: nil)
        
        let projects = ProjectsAPIResponse<[Project]> (projects: [project])
        let data = APIResponse<ProjectsAPIResponse<[Project]>>(data: projects)
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let raw = try encoder.encode(data)
        
        //when
        let response = try endpoint.parse(response: raw)
        
        //then
        switch response {
        case .success(let projects):
            let expectedResponse = [project]
            XCTAssertTrue(projects == expectedResponse, "")
        default:
            XCTFail("Ошибка парсинга ответа")
        }
    }
}
