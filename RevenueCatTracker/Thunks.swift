//
//  Thunks.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift
import ReSwiftThunk

let fetchOverview = Thunk<MainState> { dispatch, getState in
    ApiClient().overview { (overview) in
        guard let overview = overview else { return }
        DispatchQueue.main.async {
            dispatch(
                MainStateAction.overviewFetched(overview)
            )
        }
    }
}

let loginRevenueCat = Thunk<MainState> { dispatch, getState in
    guard let credentials = getState()?.credentials else {
        return
    }
    ApiClient().login(credentials: credentials) { (auth) in
        guard let auth = auth else { return }
        DispatchQueue.main.async {
            dispatch(
                MainStateAction.auth(Result.success(auth))
            )
        }
    }
}
