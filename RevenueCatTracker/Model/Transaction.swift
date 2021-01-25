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
//{"app":
//    {"id":"e1219ac1","name":"Mindful Affirmations"},"expires_date":"2021-01-28T08:32:27Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":false,"is_trial_period":true,"product_identifier":"com.joancardona.mindfulafirmations.1yearSubscriptionP3","purchase_date":"2021-01-25T08:32:27Z","revenue":0.0,"store_transaction_identifier":"340000605989374","subscriber_id":"$RCAnonymousID:2b69eb9bf218491091cf068d3d3f060e","was_refunded":false}

/*
{"first_purchase_ms":1611563547000,"last_purchase_ms":1611510956000,"transactions":[{"app":{"id":"e1219ac1","name":"Mindful Affirmations"},"expires_date":"2021-01-28T08:32:27Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":false,"is_trial_period":true,"product_identifier":"com.joancardona.mindfulafirmations.1yearSubscriptionP3","purchase_date":"2021-01-25T08:32:27Z","revenue":0.0,"store_transaction_identifier":"340000605989374","subscriber_id":"$RCAnonymousID:2b69eb9bf218491091cf068d3d3f060e","was_refunded":false},{"app":{"id":"2ec82a6b","name":"Lit Stickers"},"expires_date":"2021-01-28T06:33:43Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":false,"is_trial_period":true,"product_identifier":"com.joancardona.litstickers.montly_1","purchase_date":"2021-01-25T06:33:43Z","revenue":0.0,"store_transaction_identifier":"390000520289463","subscriber_id":"$RCAnonymousID:c36ef7fc237d43e8a3f269d5a7dde51f","was_refunded":false},{"app":{"id":"2ec82a6b","name":"Lit Stickers"},"expires_date":"2021-01-28T03:48:24Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":false,"is_trial_period":true,"product_identifier":"com.joancardona.litstickers.weekly_1","purchase_date":"2021-01-25T03:48:24Z","revenue":0.0,"store_transaction_identifier":"560000641023733","subscriber_id":"$RCAnonymousID:035f4615568c447bb46b91086f8ec0b4","was_refunded":false},{"app":{"id":"2ec82a6b","name":"Lit Stickers"},"expires_date":"2021-01-28T03:38:53Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":false,"is_trial_period":true,"product_identifier":"com.joancardona.litstickers.montly_1","purchase_date":"2021-01-25T03:38:53Z","revenue":0.0,"store_transaction_identifier":"110000919888267","subscriber_id":"$RCAnonymousID:5157e1a3bfe54448889b0f96c5e2cbe6","was_refunded":false},{"app":{"id":"2ec82a6b","name":"Lit Stickers"},"expires_date":"2021-01-28T03:04:15Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":false,"is_trial_period":true,"product_identifier":"com.joancardona.litstickers.montly_1","purchase_date":"2021-01-25T03:04:15Z","revenue":0.0,"store_transaction_identifier":"180000884352779","subscriber_id":"$RCAnonymousID:c5edf8e9fe174951839291b84cbbcdf2","was_refunded":false},{"app":{"id":"e1219ac1","name":"Mindful Affirmations"},"expires_date":"2021-02-25T00:27:13Z","is_in_introductory_price_period":false,"is_renewal":true,"is_sandbox":false,"is_trial_conversion":false,"is_trial_period":false,"product_identifier":"com.joancardona.mindfulaffirmations.1monthSubscriptionP3","purchase_date":"2021-01-25T00:27:13Z","revenue":3.99,"store_transaction_identifier":"190000929803435","subscriber_id":"5f1b6f02d36abe07e97526b0","was_refunded":false},{"app":{"id":"2ec82a6b","name":"Lit Stickers"},"expires_date":"2021-02-25T00:25:32Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":true,"is_trial_period":false,"product_identifier":"com.joancardona.litstickers.montly_1","purchase_date":"2021-01-25T00:25:32Z","revenue":9.91362310116674,"store_transaction_identifier":"460000790480875","subscriber_id":"$RCAnonymousID:69ae7a9edf14408cb879b66dce054f42","was_refunded":false},{"app":{"id":"e1219ac1","name":"Mindful Affirmations"},"expires_date":"2021-02-24T21:23:57Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":false,"is_trial_period":false,"product_identifier":"com.joancardona.mindfulaffirmations.1monthSubscriptionP3","purchase_date":"2021-01-24T21:23:57Z","revenue":5.45895590285521,"store_transaction_identifier":"480000777291678","subscriber_id":"600de58d6ed9d726931f2ab0","was_refunded":false},{"app":{"id":"e1219ac1","name":"Mindful Affirmations"},"expires_date":"2021-01-27T21:22:00Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":false,"is_trial_period":true,"product_identifier":"com.joancardona.mindfulafirmations.1yearSubscriptionP3","purchase_date":"2021-01-24T21:22:00Z","revenue":0.0,"store_transaction_identifier":"710000686996677","subscriber_id":"$RCAnonymousID:7abdc6cbc5a749f29946cd4061e1e845","was_refunded":false},{"app":{"id":"e1219ac1","name":"Mindful Affirmations"},"expires_date":"2022-01-24T17:55:56Z","is_in_introductory_price_period":false,"is_renewal":false,"is_sandbox":false,"is_trial_conversion":true,"is_trial_period":false,"product_identifier":"com.joancardona.mindfulafirmations.1yearSubscriptionP3","purchase_date":"2021-01-24T17:55:56Z","revenue":28.2634730538922,"store_transaction_identifier":"380000700760968","subscriber_id":"5ffe7bfa8f4b3b251b8a9cdb","was_refunded":false}]}

 */
