//
//  Overview.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation

struct Overview: Codable, Equatable {
    let activeSubscribers: Int
    let activeTrials: Int
    let activeUsers: Int
    let installs: Int
    let mrr: Double
    let revenue: Double
}

extension Overview {
    fileprivate enum CodingKeys: String, CodingKey {
        case activeSubscribers = "active_subscribers_count"
        case activeTrials = "active_trials_count"
        case activeUsers = "active_users_count"
        case installs = "installs_count"
        case mrr
        case revenue
    }
}



//{"active_subscribers_count":422,"active_trials_count":17,"active_users_count":9381.0,"installs_count":6354.0,"mrr":1381.32144335303,"revenue":1502.19035399478}
