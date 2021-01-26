//
//  LandingViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation

class LandingViewModel {
    var currentState: LandingState?
    
    func retrieveAuth() {
        if let authObject = UserDefaults.standard.object(forKey: Auth.persistedKey) as? Data {
            let decoder = JSONDecoder()
            if let auth = try? decoder.decode(Auth.self, from: authObject) {
                mainStore.dispatch(MainStateAction.auth(Result.success(auth)))
            } else {
                mainStore.dispatch(MainStateAction.auth(Result.error(nil)))
            }
        } else {
            mainStore.dispatch(MainStateAction.auth(Result.error(nil)))
        }
    }
}

extension LandingViewModel {
    struct LandingState: Equatable {
        var auth: Result<Auth>?
        
        init(_ state: MainState) {
            auth = state.auth
        }
    }
}
