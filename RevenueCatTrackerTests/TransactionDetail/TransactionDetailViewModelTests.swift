//
//  TransactionDetailViewModelTests.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 25/1/21.
//

import XCTest
@testable import RevenueCatTracker

class TransactionDetailViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testMapSubscriberIntoData() {
        let viewModel = TransactionDetailViewModel(timeService: TimeService())
        let subscriber = Subscriber(app: App(name: "app", id: "1"),
                                    aliases: [],
                                    appUserId: "id",
                                    attributionFields: nil,
                                    dollarsSpent: 150,
                                    createdAt: "2021-01-28T06:33:43Z",
                                    lastSeenCountry: "ES",
                                    lastSeenPlatform: "iOS",
                                    subscriberAttributes: nil,
                                    history: [HistoryEvent(at: "2021-01-28T06:33:43Z",
                                                           cancellationDate: nil,
                                                           currency: "EUR",
                                                           entitlement: "entitlement",
                                                           event: "purchase",
                                                           dateExpires: nil,
                                                           isExpired: false,
                                                           isSandbox: false,
                                                           isTrialConversion: false,
                                                           priceInPurchasedCurrency: 15.0,
                                                           priceInUSD: 17.0,
                                                           product: "123.product",
                                                           refundedAt: nil,
                                                           store: "app_store",
                                                           storeTransactionIdentifier: "store_trans",
                                                           wasRefunded: false,
                                                           alias: nil)])
        
        let data = viewModel.mapSubscriberIntoData(subscriber: subscriber)
        XCTAssertEqual(data.count, 7)
        XCTAssertEqual(data.first, TransactionDetailViewModel.TableViewData(section: .details, rowData: TransactionDetailViewModel.TableViewRowData(title: "id", detail: "App User Id")))
        XCTAssertEqual(data[1], TransactionDetailViewModel.TableViewData(section: .details, rowData: TransactionDetailViewModel.TableViewRowData(title: "app", detail: "App name")))
        XCTAssertEqual(data[2], TransactionDetailViewModel.TableViewData(section: .details, rowData: TransactionDetailViewModel.TableViewRowData(title: "ES", detail: "Country")))
        XCTAssertEqual(data[3], TransactionDetailViewModel.TableViewData(section: .details, rowData: TransactionDetailViewModel.TableViewRowData(title: "$150.00", detail: "Total Spent")))
    }
    
    func testMapSubscriberIntoAttributes() {
        let viewModel = TransactionDetailViewModel(timeService: TimeService())
        let subscriber = Subscriber(app: App(name: "app", id: "1"),
                                    aliases: [],
                                    appUserId: "id",
                                    attributionFields: nil,
                                    dollarsSpent: 150,
                                    createdAt: "2021-01-28T06:33:43Z",
                                    lastSeenCountry: "ES",
                                    lastSeenPlatform: "iOS",
                                    subscriberAttributes: nil,
                                    history: [HistoryEvent(at: "2021-01-28T06:33:43Z",
                                                           cancellationDate: nil,
                                                           currency: "EUR",
                                                           entitlement: "entitlement",
                                                           event: "purchase",
                                                           dateExpires: nil,
                                                           isExpired: false,
                                                           isSandbox: false,
                                                           isTrialConversion: false,
                                                           priceInPurchasedCurrency: 15.0,
                                                           priceInUSD: 17.0,
                                                           product: "123.product",
                                                           refundedAt: nil,
                                                           store: "app_store",
                                                           storeTransactionIdentifier: "store_trans",
                                                           wasRefunded: false,
                                                           alias: nil)])
        
        let data = viewModel.mapSubscriberIntoAttributesData(subscriber: subscriber)
        
        for d in data {
            XCTAssertEqual(d.section, .attributes)
        }
    }
    
    func testMapSubscriberIntoHistory() {
        let viewModel = TransactionDetailViewModel(timeService: TimeService())
        let subscriber = Subscriber(app: App(name: "app", id: "1"),
                                    aliases: [],
                                    appUserId: "id",
                                    attributionFields: nil,
                                    dollarsSpent: 150,
                                    createdAt: "2021-01-28T06:33:43Z",
                                    lastSeenCountry: "ES",
                                    lastSeenPlatform: "iOS",
                                    subscriberAttributes: nil,
                                    history: [HistoryEvent(at: "2021-01-28T06:33:43Z",
                                                           cancellationDate: nil,
                                                           currency: "EUR",
                                                           entitlement: "entitlement",
                                                           event: "purchase",
                                                           dateExpires: nil,
                                                           isExpired: false,
                                                           isSandbox: false,
                                                           isTrialConversion: false,
                                                           priceInPurchasedCurrency: 15.0,
                                                           priceInUSD: 17.0,
                                                           product: "123.product",
                                                           refundedAt: nil,
                                                           store: "app_store",
                                                           storeTransactionIdentifier: "store_trans",
                                                           wasRefunded: false,
                                                           alias: nil)])
        
        let data = viewModel.mapSubscriberIntoHistoryData(subscriber: subscriber)
        
        for d in data {
            XCTAssertEqual(d.section, .history)
        }
    }
    
    func testMapSubscriberIntoDetails() {
        let viewModel = TransactionDetailViewModel(timeService: TimeService())
        let subscriber = Subscriber(app: App(name: "app", id: "1"),
                                    aliases: [],
                                    appUserId: "id",
                                    attributionFields: nil,
                                    dollarsSpent: 150,
                                    createdAt: "2021-01-28T06:33:43Z",
                                    lastSeenCountry: "ES",
                                    lastSeenPlatform: "iOS",
                                    subscriberAttributes: nil,
                                    history: [HistoryEvent(at: "2021-01-28T06:33:43Z",
                                                           cancellationDate: nil,
                                                           currency: "EUR",
                                                           entitlement: "entitlement",
                                                           event: "purchase",
                                                           dateExpires: nil,
                                                           isExpired: false,
                                                           isSandbox: false,
                                                           isTrialConversion: false,
                                                           priceInPurchasedCurrency: 15.0,
                                                           priceInUSD: 17.0,
                                                           product: "123.product",
                                                           refundedAt: nil,
                                                           store: "app_store",
                                                           storeTransactionIdentifier: "store_trans",
                                                           wasRefunded: false,
                                                           alias: nil)])
        
        let data = viewModel.mapSubscriberIntoDetailsData(subscriber: subscriber)
        
        for d in data {
            XCTAssertEqual(d.section, .details)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
