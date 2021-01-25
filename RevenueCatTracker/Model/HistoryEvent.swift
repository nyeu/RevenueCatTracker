//
//  HistoryEvent.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation

struct HistoryEvent: Codable, Equatable {
    let at: String
    let cancellationDate: String?
    let currency: String?
    let entitlement: String?
    let event: String
    let dateExpires: String?
    let isExpired: Bool?
    let isSandbox: Bool?
    let isTrialConversion: Bool?
    let priceInPurchasedCurrency: Double?
    let priceInUSD: Double?
    let product: String?
    let refundedAt: String?
    let store: String?
    let storeTransactionIdentifier: String?
    let wasRefunded: Bool?
    let alias: String?
}

extension HistoryEvent {
    enum CodingKeys: String, CodingKey {
        case at
        case currency
        case cancellationDate = "cancellation_date"
        case entitlement
        case event
        case dateExpires = "expires_date"
        case isExpired = "is_expired"
        case isSandbox = "is_sandbox"
        case isTrialConversion = "is_trial_conversion"
        case priceInPurchasedCurrency = "price_in_purchased_currency"
        case priceInUSD = "price_in_usd"
        case product
        case refundedAt = "refunded_at"
        case store
        case storeTransactionIdentifier = "store_transaction_identifier"
        case wasRefunded = "was_refunded"
        case alias

    }
}

