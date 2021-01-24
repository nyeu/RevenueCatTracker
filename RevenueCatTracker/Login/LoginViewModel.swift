//
//  LoginViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift

class LoginViewModel {
    var currentState: LoginState?

    func loginTapped() {
        let credentials = mainStore.state.credentials
    }
}

extension LoginViewModel {
    struct LoginState: Equatable {
        var credentials: Credentials
        var auth: Auth?
        
        init(_ state: MainState) {
            credentials = state.credentials
            auth = state.auth
        }
    }
}
