//
//  MainState.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift
import ReSwiftThunk

struct MainState: StateType, Equatable {
    var credentials: Credentials?
    var auth: Result<Auth>?
    var overview: Overview?
    var transactionResults: [TransactionResult] = []
    var transactions: [Transaction] = []
    var selectedTransaction: Transaction?
    var sandboxMode: Bool = false
    var subscriber: Subscriber?
}

func mainReducer(action: Action, state: MainState?) -> MainState {
    var state = state ?? MainState()

    guard let action = action as? MainStateAction else {
        return state
    }

    switch action {
    case .login(let credentials):
        state.credentials = credentials
    case .auth(let auth):
        state.auth = auth
    case .overviewFetched(let overview):
        state.overview = overview
    case .transactionsFetched(let transactionResult):
        state.transactions.append(contentsOf: transactionResult.transactions)
        state.transactionResults.append(transactionResult)
    case .refreshTransactions(let transactionResult):
        state.transactions = transactionResult.transactions
        state.transactionResults = [transactionResult]
    case .changeSandboxMode(let isOn):
        state.sandboxMode = isOn
    case .selectTransaction(let transaction):
        state.selectedTransaction = transaction
    case .updateSubscriber(let subscriber):
        state.subscriber = subscriber
    }

    return state
}

enum MainStateAction: Action {
    case login(Credentials)
    case auth(Result<Auth>)
    case overviewFetched(Overview)
    case transactionsFetched(TransactionResult)
    case refreshTransactions(TransactionResult)
    case changeSandboxMode(Bool)
    case selectTransaction(Transaction?)
    case updateSubscriber(Subscriber?)
}

let thunksMiddleware: Middleware<MainState> = createThunkMiddleware()

let mainStore = Store(
    reducer: mainReducer,
    state: MainState(),
    middleware: [thunksMiddleware]
)

