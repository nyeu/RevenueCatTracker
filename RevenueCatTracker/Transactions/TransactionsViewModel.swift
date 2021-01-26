//
//  TransactionsViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation
import ReSwift

protocol TransactionsViewModelDelegate: class {
    func updateView(newState: TransactionsViewModel.TransactionState, oldState: TransactionsViewModel.TransactionState?)
}

class TransactionsViewModel: StoreSubscriber {
    enum FetchState: Equatable {
        case ready
        case fetching
    }
    
    weak var delegate: TransactionsViewModelDelegate?
    var currentState: TransactionState?
    typealias StoreSubscriberStateType = TransactionState
    let timeService: TimeService
    var fetchState: FetchState = .ready
    
    init(timeService: TimeService) {
        self.timeService = timeService
    }
    
    func subscribe() {
        mainStore.subscribe(self, transform: {
            $0.select(TransactionState.init)
        })
    }
    
    func unsubscribe() {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: TransactionState) {
        let oldState = self.currentState
        self.currentState = state
        
        if let oldStateSandbox = oldState?.sandboxMode, oldStateSandbox != state.sandboxMode {
            refreshTransactions()
        }
        if fetchState == .fetching && oldState?.transactions != state.transactions {
            fetchState = .ready
        }

        delegate?.updateView(newState: state, oldState: oldState)
    }
    
    func getTransactions() {
        fetchState = .fetching
        mainStore.dispatch(fetchTransactions)
    }
    
    func refreshTransactions() {
        fetchState = .fetching
        mainStore.dispatch(fetchRefreshedTransactions)
    }
    
    func getMoreTransactions() {
        fetchState = .fetching
        mainStore.dispatch(fetchMoreTransactions)
    }
    
    func radableDate(date: String) -> String? {
        return(timeService.readableDate(fromDate: date, toDate: timeService.now()))
    }
}

extension TransactionsViewModel {
    struct TransactionState: Equatable {
        var transactions: [Transaction]?
        var sandboxMode: Bool

        init(_ state: MainState) {
            transactions = state.transactions
            sandboxMode = state.sandboxMode
        }
    }
}
