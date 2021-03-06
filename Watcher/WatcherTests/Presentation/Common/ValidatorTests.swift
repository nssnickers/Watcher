//
//  ValidatorTests.swift
//  WatcherTests
//
//  Created by Маргарита on 12/02/2019.
//  Copyright © 2019 Маргарита. All rights reserved.
//

import XCTest

@testable import Watcher


class ValidatorTests: XCTestCase {
    
    let validator = Validator()

    func testEmptyEmailValidation() {
        //given
        let email = ""
        
        //when
        let validatorResponse = validator.validateString(email, for: .email)
        
        //then
        let error = NSLocalizedString("Неверный формат логина", comment: "")
        let errorValidatorResponse = ValidationResponse.error(error)
        XCTAssertEqual(validatorResponse, errorValidatorResponse, "Test empty email validation fail")
    }
    
    
    func testWrongEmailValidation() {
        //given
        let email = "ritret@tratatata"
        
        //when
        let validatorResponse = validator.validateString(email, for: .email)
        
        //then
        let error = NSLocalizedString("Неверный формат логина", comment: "")
        let errorValidatorResponse = ValidationResponse.error(error)
        XCTAssertEqual(validatorResponse, errorValidatorResponse, "Test wrong email validation fail")
    }
    
    
    func testValidEmailValidation() {
        //given
        let email = "ritret@tratatata.com"
        
        //when
        let validatorResponse = validator.validateString(email, for: .email)
        
        //then
        let successValidatorResponse = ValidationResponse.success
        XCTAssertEqual(validatorResponse, successValidatorResponse, "Test valid email validation fail")
    }

}
