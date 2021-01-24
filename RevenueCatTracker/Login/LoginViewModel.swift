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
    
    func persistAuth(_ auth: Auth) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(auth) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "kAuth")
        }
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
