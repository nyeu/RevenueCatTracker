//
//  App.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 25/1/21.
//

import Foundation

struct AppsResponse: Codable, Equatable {
    let apps: [App]
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
