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
    weak var delegate: TransactionsViewModelDelegate?
    var currentState: TransactionState?
    typealias StoreSubscriberStateType = TransactionState
    let timeService: TimeService
    
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
        if oldState?.sandboxMode != state.sandboxMode {
            getTransactions()
        }

        delegate?.updateView(newState: state, oldState: oldState)
    }
    
    func getTransactions() {
        mainStore.dispatch(fetchTransactions)
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
