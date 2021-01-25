//
//  AttributionFields.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation

struct AttributionFields: Codable, Equatable {
    let adgroup: String
    let campaign: String
    let creative: String?
    let keyword: String?
    let network: String
    let source: String
}
