//
//  SubscriberTests.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 25/1/21.
//

import XCTest
@testable import RevenueCatTracker

class SubscriberTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodingSubscriber() {
        guard let path = Bundle.init(for: self.classForCoder).path(forResource: "SubscriberData", ofType: "json") else { fatalError("Can't find SubscriberData.json file") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't convert json into data") }
        let response = try? JSONDecoder().decode(SubscriberResponse.self, from: data)

        XCTAssertNotNil(response)
    }

    func testSubscriberValues() {
        guard let path = Bundle.init(for: self.classForCoder).path(forResource: "SubscriberData", ofType: "json") else { fatalError("Can't find SubscriberData.json file") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't convert json into data") }
        let response = try? JSONDecoder().decode(SubscriberResponse.self, from: data)
        let subscriber = response?.subscriber
        
        XCTAssertEqual(subscriber?.app.name, "Mindful Affirmations")
        XCTAssertEqual(subscriber?.app.id, "e1219acsaD1")
        XCTAssertEqual(subscriber?.appUserId, "$RCAnonymousID:226dc4a3/XDea3825a4cd9415dSSSAAAAfb")
        XCTAssertNotNil(subscriber?.attributionFields)
        XCTAssertEqual(subscriber?.dollarsSpent, 10.0)
        XCTAssertNotNil(subscriber?.history)
    }
    
    func testSubscriberHistoryValues() {
        guard let path = Bundle.init(for: self.classForCoder).path(forResource: "SubscriberData", ofType: "json") else { fatalError("Can't find SubscriberData.json file") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't convert json into data") }
        let response = try? JSONDecoder().decode(SubscriberResponse.self, from: data)
        let history = response?.subscriber.history
        
        XCTAssertEqual(history?.count, 3)
    }
    
    func testSubscriberAttributionValues() {
        guard let path = Bundle.init(for: self.classForCoder).path(forResource: "SubscriberData", ofType: "json") else { fatalError("Can't find SubscriberData.json file") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't convert json into data") }
        let response = try? JSONDecoder().decode(SubscriberResponse.self, from: data)
        let att = response?.subscriber.attributionFields
        
        XCTAssertEqual(att?.campaign, "Mindful Affirmations - 14730SSS19675")
        XCTAssertEqual(att?.adgroup, "Mindful Affirmations - 14730196SSS75")
        XCTAssertEqual(att?.keyword, "keyword")
        XCTAssertNil(att?.creative)
        XCTAssertEqual(att?.source, "Apple Search Ads")
        XCTAssertEqual(att?.network, "Apple Search Ads")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
