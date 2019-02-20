//
//  ProjectServiceTests.swift
//  WatcherTests
//
//  Created by Маргарита on 15/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import XCTest

@testable import Watcher


class ProjectServiceTests: XCTestCase {
    
    let projectService = ProjectService()
    let authService = AuthService()
    
    func testObtainProject() {
        //given
        let expectation = XCTestExpectation(description: "obtain project")
        
        //when
        authService.loginWithEmail(
            "hmargotret@gmail.com",
            password: "marga1Rita") { (result) in
                switch result {
                case .success:
                    self.projectService.obtainProjectsWithCompletion { (result) in
                        XCTAssertNotNil(result, "Не должно быть пустого ответа")
                        
                        switch result {
                        case .error(let error):
                            XCTFail("Ошибка при получении списка проектов: \(error)")
                        case .success(let projects):
                            XCTAssertNotNil(projects, "Не должно быть пустого списка проектов")
                        }
                        expectation.fulfill()
                    }
                case .error(let error):
                    XCTFail("Ошибка авторизации при тестировании: \(error)")
                }
        }
        
        
        //then
        wait(for: [expectation], timeout: 10.0)
    }
}
