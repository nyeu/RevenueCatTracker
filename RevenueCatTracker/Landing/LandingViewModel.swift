//
//  LandingViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift

protocol LandingViewModelDelegate: class {
    func updateView(oldState: LandingViewModel.LandingState?, newState: LandingViewModel.LandingState)
}
class LandingViewModel {
    weak var delegate: LandingViewModelDelegate?
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
    
    func subscribe() {
        mainStore.subscribe(self, transform: {
            $0.select(LandingViewModel.LandingState.init)
        })
    }
    
    func unsubscribe() {
        mainStore.unsubscribe(self)
    }
}

// MARK: StoreSubscriber
extension LandingViewModel: StoreSubscriber {
    typealias StoreSubscriberStateType = LandingViewModel.LandingState
    
    func newState(state: LandingViewModel.LandingState) {
        let oldState = self.currentState
        self.currentState = state
        delegate?.updateView(oldState: oldState, newState: state)
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
