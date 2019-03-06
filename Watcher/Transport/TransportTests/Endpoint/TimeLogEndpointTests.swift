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

    func testLoggedTimeRequest() throws {
        //given
        let timeToLog = TimeToLog(
            projectId: 20,
            minutesSpent: 20,
            date: "14-12-2012",
            description: "my lovely endpoint")
        let endpoint = TimeLogEndpoint(timeLog: timeToLog)
        
        //when
        let request = try endpoint.request()
        let components = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
        
        //then
        var expectedComponents = URLComponents()
        expectedComponents.scheme = "https"
        expectedComponents.host = "watcher.intern.redmadrobot.com"
        expectedComponents.path = "/api/v1/logged-time/"
        let expectedHttpMethod = HTTPMethod.post
        
        XCTAssertEqual(expectedComponents.scheme, components?.scheme)
        XCTAssertEqual(expectedComponents.host, components?.host)
        XCTAssertEqual(expectedComponents.path, components?.path)
        XCTAssertEqual(request.httpMethod, expectedHttpMethod.rawValue)
    }

}
