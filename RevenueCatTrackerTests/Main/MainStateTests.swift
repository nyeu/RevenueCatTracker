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
    
    func testAuth() {
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
    
    func testOverview() {
        let mockedIntValue = 10
        let mockedDoubleValue = 100.0
        let overview = Overview(activeSubscribers: mockedIntValue,
                                activeTrials: mockedIntValue,
                                activeUsers: mockedIntValue,
                                installs: mockedIntValue,
                                mrr: mockedDoubleValue,
                                revenue: mockedDoubleValue)
        
        let action = MainStateAction.overviewFetched(overview)
        
        let state = mainReducer(action: action, state: nil)
        
        XCTAssertEqual(state.overview, overview)
    }
    
    func testSandboxModeToTrue() {
        let action = MainStateAction.changeSandboxMode(true)
        
        let state = mainReducer(action: action, state: nil)
        
        XCTAssertEqual(state.sandboxMode, true)
    }
    
    func testSandboxModeToFalse() {
        let action = MainStateAction.changeSandboxMode(false)
        
        let state = mainReducer(action: action, state: nil)
        
        XCTAssertEqual(state.sandboxMode, false)
    }
    
    
    func testSelectedTransaction() {
       let transaction = Transaction(app: App(name: "app", id: "123"),
                                     isTrial: false,
                                     productIdentifier: "id",
                                     subscriberId: "ids",
                                     isTrialConversion: false,
                                     isRenewal: false,
                                     wasRefunded: false,
                                     revenue: 15.0,
                                     isSandbox: false,
                                     expirationDate: "2021-01-28T06:33:43Z",
                                     purchasedDate: "2021-01-28T06:33:43Z")

        let action = MainStateAction.selectTransaction(transaction)

        let state = mainReducer(action: action, state: nil)
        
        XCTAssertEqual(state.selectedTransaction, transaction)
    }
    
    func testRemoveSelectedTransaction() {
       let transaction = Transaction(app: App(name: "app", id: "123"),
                                     isTrial: false,
                                     productIdentifier: "id",
                                     subscriberId: "ids",
                                     isTrialConversion: false,
                                     isRenewal: false,
                                     wasRefunded: false,
                                     revenue: 15.0,
                                     isSandbox: false,
                                     expirationDate: "2021-01-28T06:33:43Z",
                                     purchasedDate: "2021-01-28T06:33:43Z")

        let action = MainStateAction.selectTransaction(transaction)
        let state = mainReducer(action: action, state: nil)
       
        let removeTransaction = MainStateAction.selectTransaction(nil)
        let stateAfter = mainReducer(action: removeTransaction, state: state)

        XCTAssertNil(stateAfter.selectedTransaction)
    }

    func testAddSubscriber() {
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
        
        let action = MainStateAction.updateSubscriber(subscriber)
        let state = mainReducer(action: action, state: nil)
       
        let removeSubscriber = MainStateAction.updateSubscriber(nil)
        let stateAfter = mainReducer(action: removeSubscriber, state: state)

        XCTAssertNil(stateAfter.subscriber)
    }

    func testRemoveSubscriber() {
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
        
        let action = MainStateAction.updateSubscriber(subscriber)
        
        let state = mainReducer(action: action, state: nil)
        
        XCTAssertEqual(state.subscriber, subscriber)
    }
    
    func testTransactionResult() {
        let transaction = Transaction(app: App(name: "app", id: "123"),
                                      isTrial: false,
                                      productIdentifier: "id",
                                      subscriberId: "ids",
                                      isTrialConversion: false,
                                      isRenewal: false,
                                      wasRefunded: false,
                                      revenue: 15.0,
                                      isSandbox: false,
                                      expirationDate: "2021-01-28T06:33:43Z",
                                      purchasedDate: "2021-01-28T06:33:43Z")
        
        let transactionResult1 = TransactionResult(firstPurchase: 1000200, lastPurchase: 20003000, transactions: [transaction])
        let action = MainStateAction.transactionsFetched(transactionResult1)
        let state = mainReducer(action: action, state: nil)
        
        XCTAssertEqual(state.transactionResults, [transactionResult1])
    }
    
    func testAppendTransactionResult() {
        let transaction = Transaction(app: App(name: "app", id: "123"),
                                      isTrial: false,
                                      productIdentifier: "id",
                                      subscriberId: "ids",
                                      isTrialConversion: false,
                                      isRenewal: false,
                                      wasRefunded: false,
                                      revenue: 15.0,
                                      isSandbox: false,
                                      expirationDate: "2021-01-28T06:33:43Z",
                                      purchasedDate: "2021-01-28T06:33:43Z")
        
        let transactionResult1 = TransactionResult(firstPurchase: 1000200, lastPurchase: 20003000, transactions: [transaction])
        let action = MainStateAction.transactionsFetched(transactionResult1)
        let state = mainReducer(action: action, state: nil)
        
        let transactionResult2 = TransactionResult(firstPurchase: 1000200, lastPurchase: 20003000, transactions: [transaction, transaction])
        let action2 = MainStateAction.transactionsFetched(transactionResult2)
        let newState = mainReducer(action: action2, state: state)

        
        XCTAssertEqual(newState.transactions.count, 3)
    }
    
    func testRefreshTransactionsSubstitutesOldTransactions() {
        let transaction = Transaction(app: App(name: "app", id: "123"),
                                      isTrial: false,
                                      productIdentifier: "id",
                                      subscriberId: "ids",
                                      isTrialConversion: false,
                                      isRenewal: false,
                                      wasRefunded: false,
                                      revenue: 15.0,
                                      isSandbox: false,
                                      expirationDate: "2021-01-28T06:33:43Z",
                                      purchasedDate: "2021-01-28T06:33:43Z")
        
        // Add first Batch of transactions
        let transactionResult1 = TransactionResult(firstPurchase: 1000200, lastPurchase: 20003000, transactions: [transaction])
        let action = MainStateAction.transactionsFetched(transactionResult1)
        let state = mainReducer(action: action, state: nil)
        
        // Append new transactions
        let transactionResult2 = TransactionResult(firstPurchase: 1000200, lastPurchase: 20003000, transactions: [transaction, transaction])
        let action2 = MainStateAction.transactionsFetched(transactionResult2)
        let newState = mainReducer(action: action2, state: state)

        // Refresh will substitute all previous transactions with a new batch of the latest only
        let transactionResultRefreshed = TransactionResult(firstPurchase: 1000200, lastPurchase: 20003000, transactions: [transaction])
        let actionRefresh = MainStateAction.refreshTransactions(transactionResultRefreshed)
        let newRefreshedState = mainReducer(action: actionRefresh, state: newState)

        
        XCTAssertEqual(newRefreshedState.transactionResults, [transactionResultRefreshed])
        XCTAssertEqual(newRefreshedState.transactions, transactionResultRefreshed.transactions)
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
