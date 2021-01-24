//
//  LoginViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift

struct LoginViewModel {
    
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
            auth = nil
        }
    }
}
