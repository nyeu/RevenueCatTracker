//
//  Auth.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation

struct Auth: Codable, Equatable {
    static let persistedKey: String = "kAuth"
    
    let authenticationToken: String
    let expirationToken: String
}

extension Auth {
    fileprivate enum CodingKeys: String, CodingKey {
        case authenticationToken = "authentication_token"
        case expirationToken = "authentication_token_expiration"
    }
}
