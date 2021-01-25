//
//  Subscriber.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation

struct SubscriberResponse: Codable, Equatable {
    let subscriber: Subscriber
}

struct Subscriber: Codable, Equatable {
    let app: App
    let aliases: [String]
    let appUserId: String
    let attributionFields: AttributionFields?
    let dollarsSpent: Double
    let createdAt: String
    let lastSeenCountry: String
    let lastSeenPlatform: String
    let subscriberAttributes: [Attribute]?
    let history: [HistoryEvent]
}

extension Subscriber {
    enum CodingKeys: String, CodingKey {
        case app
        case aliases
        case appUserId = "app_user_id"
        case attributionFields = "attribution_fields"
        case dollarsSpent = "dollars_spent"
        case createdAt = "created_at"
        case lastSeenCountry = "last_seen_country"
        case lastSeenPlatform = "last_seen_platform"
        case subscriberAttributes = "subscriber_attributes"
        case history
    }
}
