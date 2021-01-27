//
//  LoginViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift

protocol LoginViewModelDelegate: class {
    func updateView(oldState: LoginViewModel.LoginState?, newState: LoginViewModel.LoginState)
}
class LoginViewModel {
    weak var delegate: LoginViewModelDelegate?
    var currentState: LoginState?
    let validator: Validator
    
    init(validator: Validator) {
        self.validator = validator
    }
    
    func validateCredentials(_ credentials: Credentials) -> Bool {
        return credentials.password.count > 0 && validator.isValidEmail(credentials.email)
    }
    
    func subscribe() {
        mainStore.subscribe(self, transform: {
            $0.select(LoginViewModel.LoginState.init)
        })
    }
    
    func unsubscribe() {
        mainStore.unsubscribe(self)
    }
}

// MARK: StoreSubscriber
extension LoginViewModel: StoreSubscriber {
    typealias StoreSubscriberStateType = LoginViewModel.LoginState
    
    func newState(state: LoginViewModel.LoginState) {
        let oldState = self.currentState
        self.currentState = state
        delegate?.updateView(oldState: oldState, newState: state)
    }
}

extension LoginViewModel {
    struct LoginState: Equatable {
        var credentials: Credentials?
        var auth: Result<Auth>?
        
        init(_ state: MainState) {
            credentials = state.credentials
            auth = state.auth
        }
    }
}
