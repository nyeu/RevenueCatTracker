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
        delegate?.updateView(newState: state, oldState: oldState)
    }
    
    func getTransactions() {
        mainStore.dispatch(fetchTransactions)
    }
}

extension TransactionsViewModel {
    struct TransactionState: Equatable {
        var transactions: [Transaction]?
        
        init(_ state: MainState) {
            transactions = state.transactions
        }
    }
}
