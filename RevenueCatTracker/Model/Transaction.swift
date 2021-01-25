//
//  Transaction.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation

struct TransactionResult: Codable, Equatable {
    let firstPurchase: Double
    let lastPurchase: Double
    let transactions: [Transaction]

}

extension TransactionResult {
    enum CodingKeys: String, CodingKey {
        case transactions
        case firstPurchase = "first_purchase_ms"
        case lastPurchase = "last_purchase_ms"
    }
}

struct Transaction: Codable, Equatable {
    let app: App
    let isTrial: Bool
    let productIdentifier: String
    let subscriberId: String
    let isTrialConversion: Bool
    let isRenewal: Bool
    let wasRefunded: Bool
    let revenue: Double
    let isSandbox: Bool
    let expirationDate: String
    var tag: TransactionTag {
        guard !isTrial else {
            return .trial
        }
        guard !isTrialConversion else {
            return .trialConversion
        }
        guard !isRenewal else {
            return .renewal
        }
        return .purchase
    }
}

extension Transaction {
    enum CodingKeys: String, CodingKey {
        case app = "app"
        case isTrial = "is_trial_period"
        case isTrialConversion = "is_trial_conversion"
        case productIdentifier = "product_identifier"
        case subscriberId = "subscriber_id"
        case isRenewal = "is_renewal"
        case wasRefunded = "was_refunded"
        case revenue
        case isSandbox = "is_sandbox"
        case expirationDate = "expires_date"
    }
}

struct App: Codable, Equatable {
    let name: String
    let id: String
}

extension App {
    enum CodingKeys: String, CodingKey {
        case name
        case id
    }
}

enum TransactionTag: String {
    case trial
    case trialConversion
    case purchase
    case renewal
    
    func prettify() -> String {
        switch self {
        case .purchase:
            return "purchase"
        case .trialConversion:
            return "trial conversion"
        case .trial:
            return "trial"
        case .renewal:
            return "renewal"
        }
    }
}
