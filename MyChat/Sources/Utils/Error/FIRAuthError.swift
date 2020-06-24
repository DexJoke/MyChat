//
//  FIRAuthError.swift
//  MyChat
//
//  Created by dexjoke on 6/18/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation

enum FIRAuthError: Int {
    case emailAlreadyInUse = 17007
    case invalidEmail = 17008
    case wrongPassword = 17009
    case userNotFound = 17011
    case networkError = 17020
    
    func message() -> String {
        switch self {
        case .emailAlreadyInUse:
            return "Account already exists"
        case .invalidEmail:
            return "The email is invalid."
        case .wrongPassword:
            return "wrong password"
        case .userNotFound:
            return "user account was not found"
        case .networkError:
            return "network error"
        default : return "unknow"
        }
    }
}

