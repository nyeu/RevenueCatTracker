//
//  ValidatorTests.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 26/1/21.
//

import XCTest
@testable import RevenueCatTracker

class ValidatorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidateCorrectEmail() throws {
        let validEmail = "joan@gmail.com"
        let validator = Validator()
        
        XCTAssertTrue(validator.isValidEmail(validEmail))
    }
    
    func testInvalidateIncorrectEmail() throws {
        let invalidEmail = "joangmail.com"
        let validator = Validator()
        
        XCTAssertFalse(validator.isValidEmail(invalidEmail))
    }
    
    func testInvalidateIncorrectEmail2() throws {
        let invalidEmail = "joangmail@com"
        let validator = Validator()
        
        XCTAssertFalse(validator.isValidEmail(invalidEmail))
    }
    
    func testInvalidateEmptyEmail() throws {
        let emptyEmail = ""
        let validator = Validator()
        
        XCTAssertFalse(validator.isValidEmail(emptyEmail))
    }
    
    func testValidateEmail() throws {
        let validEmail = "joan.12312.kalls@gmail.co.uk"
        let validator = Validator()
        
        XCTAssertTrue(validator.isValidEmail(validEmail))
    }
    
    func testValidateEmail2() throws {
        let validEmail = "joan.12312.kalls@gmail2.co.uk"
        let validator = Validator()
        
        XCTAssertTrue(validator.isValidEmail(validEmail))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
