//
//  Attribute.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation

struct Attribute: Codable, Equatable {
    let key: String
    let value: AttributeValue
}

struct AttributeValue: Codable, Equatable {
    let value: String
    let updatedAtMs: Double
}

extension AttributeValue {
    enum CodingKeys: String, CodingKey {
        case value
        case updatedAtMs = "updated_at_ms"
    }
}
