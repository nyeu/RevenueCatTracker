//
//  TimeServiceTests.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 25/1/21.
//

import XCTest
@testable import RevenueCatTracker

class TimeServiceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReadableDateFailsOnWrongFormat() {
        let service = TimeService()
        let wrongFormattedDate = "11-11-2012"
        
        XCTAssertNil(service.readableDate(fromDate: wrongFormattedDate, toDate: wrongFormattedDate))
    }
    
    func testReadableShortDateSucceedsPastDate() {
        let fromDate = "2021-01-25T08:32:27Z"
        let toDate = "2021-01-25T08:42:27Z"
        let service = TimeService()

        let readableDate = service.readableDate(fromDate: fromDate, toDate: toDate)
        XCTAssertEqual(readableDate, "10 min. ago")
    }
    
    func testReadableShortDateSucceedsFutureDate() {
        let fromDate = "2021-01-25T08:32:37Z"
        let toDate = "2021-01-25T08:32:27Z"
        let service = TimeService()

        let readableDate = service.readableDate(fromDate: fromDate, toDate: toDate)
        XCTAssertEqual(readableDate, "in 10 sec.")
    }
    
    func testReadableFullDateSucceedsPastDate() {
        let fromDate = "2021-01-25T08:32:27Z"
        let toDate = "2021-01-25T08:42:27Z"
        let service = TimeService()

        let readableDate = service.readableDate(fromDate: fromDate, toDate: toDate, unitStyle: .full)
        XCTAssertEqual(readableDate, "10 minutes ago")
    }
    
    func testReadableFullDateSucceedsFutureDate() {
        let fromDate = "2021-01-25T08:32:37Z"
        let toDate = "2021-01-25T08:32:27Z"
        let service = TimeService()

        let readableDate = service.readableDate(fromDate: fromDate, toDate: toDate, unitStyle: .full)
        XCTAssertEqual(readableDate, "in 10 seconds")
    }
  
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
