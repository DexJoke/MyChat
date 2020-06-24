//
//  UserDefaultManager.swift
//  MyChat
//
//  Created by dexjoke on 6/19/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation

class UserManager {
    static let instance  = UserManager()
    
    func isLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultKey.isLogin)
    }
    
    func logged() {
        UserDefaults.standard.set(true, forKey: UserDefaultKey.isLogin)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.isLogin)
    }
}
