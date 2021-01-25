//
//  OverviewTest.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 25/1/21.
//

import XCTest
@testable import RevenueCatTracker

class OverviewTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDecodingOverview() {
        guard let path = Bundle.init(for: self.classForCoder).path(forResource: "OverviewData", ofType: "json") else { fatalError("Can't find OverviewData.json file") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't convert json into data") }
        let response = try? JSONDecoder().decode(Overview.self, from: data)

        XCTAssertNotNil(response)
    }
    
    func testOverviewValues() {
        guard let path = Bundle.init(for: self.classForCoder).path(forResource: "OverviewData", ofType: "json") else { fatalError("Can't find OverviewData.json file") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't convert json into data") }
        let response = try? JSONDecoder().decode(Overview.self, from: data)
        
        XCTAssertEqual(response?.revenue, 15337.84640605269)
        XCTAssertEqual(response?.mrr, 13393.57575047265)
        XCTAssertEqual(response?.activeSubscribers, 4224)
        XCTAssertEqual(response?.activeTrials, 21)
        XCTAssertEqual(response?.activeUsers, 9484)
        XCTAssertEqual(response?.installs, 6429)
    }
    
    func testOverviewKeysAreOrderedCorrectly() {
        let overview = Overview(activeSubscribers: 10,
                                activeTrials: 10,
                                activeUsers: 10,
                                installs: 10,
                                mrr: 10,
                                revenue: 10)
        
        XCTAssertEqual(overview.orderedKeys, [Overview.CodingKeys.revenue,
                                              Overview.CodingKeys.mrr,
                                              Overview.CodingKeys.activeSubscribers,
                                              Overview.CodingKeys.activeTrials,
                                              Overview.CodingKeys.activeUsers,
                                              Overview.CodingKeys.installs])
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
