//
//  LoginActions.swift
//  RevenueCatTracker
//
//  Created by Joan Cardona on 24/1/21.
//

import Foundation
import ReSwift

enum LoginViewStateAction: Action {
    case fillEmail(String)
    case fillPassword(String)
}
