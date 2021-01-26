//
//  TransactionViewModelTests.swift
//  RevenueCatTrackerTests
//
//  Created by Joan Cardona on 26/1/21.
//

import XCTest
@testable import RevenueCatTracker
import ReSwift

class TransactionViewModelTests: XCTestCase {

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

    func testFetchStateInitAsReady() throws {
        let viewModel = TransactionsViewModel(timeService: TimeService())
        
        XCTAssertEqual(viewModel.fetchState, .ready)
    }
    
    func testFetchStateIsFetchingWhenGettingTransactions() throws {
        let viewModel = TransactionsViewModel(timeService: TimeService())
        viewModel.getTransactions()
        XCTAssertEqual(viewModel.fetchState, .fetching)
    }
    
    func testFetchStateIsFetchingWhenGettingMoreTransactions() throws {
        let viewModel = TransactionsViewModel(timeService: TimeService())
        viewModel.getMoreTransactions()
        XCTAssertEqual(viewModel.fetchState, .fetching)
    }
    
    func testFetchStateIsBackToReadyAfterTransaction() throws {
        let viewModel = TransactionsViewModel(timeService: TimeService())
        viewModel.getTransactions()
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
        
        let transactionState = TransactionsViewModel.TransactionState.init(state)
        viewModel.newState(state: transactionState)
        XCTAssertEqual(viewModel.fetchState, .ready)
    }
    
    func testFetchStateIsBackToReadyAfterMoreTransactions() throws {
        let viewModel = TransactionsViewModel(timeService: TimeService())
        viewModel.getMoreTransactions()
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
        
        let transactionState = TransactionsViewModel.TransactionState.init(state)
        viewModel.newState(state: transactionState)
        XCTAssertEqual(viewModel.fetchState, .ready)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
