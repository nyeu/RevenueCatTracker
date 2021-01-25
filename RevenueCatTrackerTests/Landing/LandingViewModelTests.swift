//
//  LandingViewModelTests.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 25/1/21.
//

import XCTest
import ReSwift

@testable import RevenueCatTracker


class LandingViewModelTests: XCTestCase {

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

    func testRetrieveAuthFromUserDefaultsWhenEmpty() {
        let viewModel = LandingViewModel()
        let store = makeStore()
        
        viewModel.retrieveAuth()
        
        XCTAssertNil(store.state.auth)
    }
    
    func testRetrieveAuthFromUserDefaultsWhenNotEmpty() {
        let auth = Auth(authenticationToken: "123",
                        expirationToken: "122")
        let defaults = UserDefaults.standard
        guard let encoder = try? JSONEncoder().encode(auth) else { fatalError("Couldn't encode auth") }
        defaults.set(encoder, forKey: "kAuth")
        let action = MainStateAction.auth(Result.success(auth))
        let state = mainReducer(action: action, state: nil)
        let viewModel = LandingViewModel()
        
        viewModel.retrieveAuth()
        
        XCTAssertNotNil(state.auth)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
