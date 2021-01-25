//
//  DashboardViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift

protocol DashboardViewModelDelegate: class {
    func updateView(newState: DashboardViewModel.DashboardState, oldState: DashboardViewModel.DashboardState?)
}

class DashboardViewModel: StoreSubscriber {
    weak var delegate: DashboardViewModelDelegate?
    var currentState: DashboardState?
    typealias StoreSubscriberStateType = DashboardState

    func subscribe() {
        mainStore.subscribe(self, transform: {
            $0.select(DashboardViewModel.DashboardState.init)
        })
        getOverview()
    }
    
    func unsubscribe() {
        mainStore.unsubscribe(self)
    }
    
    func newState(state: DashboardState) {
        let oldState = self.currentState
        self.currentState = state
        delegate?.updateView(newState: state, oldState: oldState)
    }
    
    func getOverview() {
        mainStore.dispatch(fetchOverview)
    }
}

extension DashboardViewModel {
    struct DashboardState: Equatable {
        var overview: Overview?
        
        init(_ state: MainState) {
            overview = state.overview
        }
    }
}
