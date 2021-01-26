//
//  Thunks.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift
import ReSwiftThunk

let loginRevenueCat = Thunk<MainState> { dispatch, getState in
    guard let credentials = getState()?.credentials else {
        return
    }
    
    guard Validator().isValidEmail(credentials.email) else {
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

let fetchOverview = Thunk<MainState> { dispatch, getState in
    ApiClient().overview(sandboxMode: getState()?.sandboxMode ?? false) { (overview) in
        guard let overview = overview else { return }
        DispatchQueue.main.async {
            dispatch(
                MainStateAction.overviewFetched(overview)
            )
        }
    }
}

let fetchTransactions = Thunk<MainState> { dispatch, getState in
    ApiClient().transactions(sandboxMode: getState()?.sandboxMode ?? false) { (transactionResult) in
        guard let transactionResult = transactionResult else { return }
        DispatchQueue.main.async {
            dispatch(
                MainStateAction.transactionsFetched(transactionResult)
            )
        }
    }
}

let fetchRefreshedTransactions = Thunk<MainState> { dispatch, getState in
    ApiClient().transactions(sandboxMode: getState()?.sandboxMode ?? false) { (transactionResult) in
        guard let transactionResult = transactionResult else { return }
        DispatchQueue.main.async {
            dispatch(
                MainStateAction.refreshTransactions(transactionResult)
            )
        }
    }
}

let fetchMoreTransactions = Thunk<MainState> { dispatch, getState in
    guard let lastTransactionFetched = getState()?.transactionResults.last, let state = getState() else {
        return
    }

    ApiClient().transactions(sandboxMode: getState()?.sandboxMode ?? false, startFrom: String(Int(lastTransactionFetched.lastPurchase))) { (transactionResult) in
        guard let transactionResult = transactionResult else { return }
        DispatchQueue.main.async {
            dispatch(
                MainStateAction.transactionsFetched(transactionResult)
            )
        }
    }
}


let fetchSubscriber = Thunk<MainState> { dispatch, getState in
    guard let transaction = getState()?.selectedTransaction else {
        return
    }
    ApiClient().subscriber(sandboxMode: getState()?.sandboxMode ?? false, appId: transaction.app.id, subscriberId: transaction.subscriberId) { (subscriber) in
        guard let subscriber = subscriber else { return }
        DispatchQueue.main.async {
            dispatch(
                MainStateAction.updateSubscriber(subscriber.subscriber)
            )
        }
    }
}

