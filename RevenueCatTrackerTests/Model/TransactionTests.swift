//
//  TransactionTests.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 25/1/21.
//

import XCTest
@testable import RevenueCatTracker

class TransactionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecodingTransaction() {
        guard let path = Bundle.init(for: self.classForCoder).path(forResource: "TransactionData", ofType: "json") else { fatalError("Can't find TransactionData.json file") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't convert json into data") }
        let response = try? JSONDecoder().decode(TransactionResult.self, from: data)

        XCTAssertNotNil(response)
    }
    
    func testTransactionValues() {
        guard let path = Bundle.init(for: self.classForCoder).path(forResource: "TransactionData", ofType: "json") else { fatalError("Can't find OverviewData.json file") }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { fatalError("Can't convert json into data") }
        let response = try? JSONDecoder().decode(TransactionResult.self, from: data)
        let firstTransaction = response?.transactions.first
        
        XCTAssertEqual(firstTransaction?.app.name, "Mindful Affirmations")
        XCTAssertEqual(firstTransaction?.isTrial, true)
        XCTAssertEqual(firstTransaction?.isTrialConversion, false)
        XCTAssertEqual(firstTransaction?.isSandbox, false)
    }
    
    func testRenewalTag() {
        let transaction = Transaction(app: App(name: "", id: ""),
                                      isTrial: false,
                                      productIdentifier: "",
                                      subscriberId: "",
                                      isTrialConversion: false,
                                      isRenewal: true,
                                      wasRefunded: false,
                                      revenue: 10.0,
                                      isSandbox: false,
                                      expirationDate: "222")
        
        XCTAssertEqual(transaction.tag, .renewal)
    }
    
    func testTrailTag() {
        let transaction = Transaction(app: App(name: "", id: ""),
                                      isTrial: true,
                                      productIdentifier: "",
                                      subscriberId: "",
                                      isTrialConversion: false,
                                      isRenewal: true,
                                      wasRefunded: false,
                                      revenue: 0.0,
                                      isSandbox: false,
                                      expirationDate: "222")
        
        XCTAssertEqual(transaction.tag, .trial)
    }
    
    func testTrailConversionTag() {
        let transaction = Transaction(app: App(name: "", id: ""),
                                      isTrial: false,
                                      productIdentifier: "",
                                      subscriberId: "",
                                      isTrialConversion: true,
                                      isRenewal: true,
                                      wasRefunded: false,
                                      revenue: 0.0,
                                      isSandbox: false,
                                      expirationDate: "222")
        
        XCTAssertEqual(transaction.tag, .trialConversion)
    }
    
    func testPurchaseConversionTag() {
        let transaction = Transaction(app: App(name: "", id: ""),
                                      isTrial: false,
                                      productIdentifier: "",
                                      subscriberId: "",
                                      isTrialConversion: false,
                                      isRenewal: false,
                                      wasRefunded: false,
                                      revenue: 0.0,
                                      isSandbox: false,
                                      expirationDate: "222")
        
        XCTAssertEqual(transaction.tag, .purchase)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
