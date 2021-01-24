//
//  DashboardViewModel.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation

class DashboardViewModel {
    var currentState: DashboardState?
    
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
