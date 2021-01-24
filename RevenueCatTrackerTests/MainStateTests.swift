//
//  MainStateTests.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 24/1/21.
//

import XCTest
import ReSwift

@testable import RevenueCatTracker

struct EmptyAction: Action { }

class MainStateTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func makeStore() -> Store<MainState> {
        return Store(
            reducer: mainReducer,
            state: MainState(),
            middleware: []
        )
    }

    func testInitialState() {
        let state = mainReducer(action: EmptyAction(), state: nil)
        XCTAssertEqual(state, MainState())
    }
    
    func testAddCredentials() {
        let action = MainStateAction.login(Credentials(email: "test@gmail.com",
                                                       password: "password"))
        
        let state = mainReducer(action: action, state: nil)
        
        XCTAssertEqual(state.credentials?.email, "test@gmail.com")
        XCTAssertEqual(state.credentials?.password, "password")
    }
    
    func testAuthSuccessfully() {
        let token = "aToken"
        let expirationDate = "ExpirationDate"
        let auth = Auth(authenticationToken: token,
                        expirationToken: expirationDate)
        let action = MainStateAction.auth(Result.success(auth))
        
        let state = mainReducer(action: action, state: nil)

        switch state.auth {
        case .success(let a):
            XCTAssertEqual(a.authenticationToken, token)
            XCTAssertEqual(a.expirationToken, expirationDate)
        default:
            XCTFail("Failed to get Auth")
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
