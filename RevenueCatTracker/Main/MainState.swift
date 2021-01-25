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
    var transactions: [Transaction]?
    var sandboxMode: Bool = false
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
    case .transactionsFetched(let transactions):
        state.transactions = transactions
    case .changeSandboxMode(let isOn):
        state.sandboxMode = isOn
    }

    return state
}

enum MainStateAction: Action {
    case login(Credentials)
    case auth(Result<Auth>)
    case overviewFetched(Overview)
    case transactionsFetched([Transaction])
    case changeSandboxMode(Bool)
}

let thunksMiddleware: Middleware<MainState> = createThunkMiddleware()

let mainStore = Store(
    reducer: mainReducer,
    state: MainState(),
    middleware: [thunksMiddleware]
)

