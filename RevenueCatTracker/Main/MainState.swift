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
    var credentials: Credentials = Credentials(email: "", password: "")
    var auth: Auth?

}

func mainReducer(action: Action, state: MainState?) -> MainState {
    var state = state ?? MainState()

    guard let action = action as? MainStateAction else {
        return state
    }

    switch action {
    case .login(let credentials):
        state.credentials = credentials
    case .authSuccessfully(let auth):
        state.auth = auth
    }

    return state
}

enum MainStateAction: Action {
    case login(Credentials)
    case authSuccessfully(Auth)
}

let thunksMiddleware: Middleware<MainState> = createThunkMiddleware()

let mainStore = Store(
    reducer: mainReducer,
    state: MainState(),
    middleware: [thunksMiddleware]
)

