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
        return UserDefaults.standard.bool(forKey: UserDefaultKey.login)
    }
    
    func logged() {
        UserDefaults.standard.set(true, forKey: UserDefaultKey.login)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKey.login)
    }
    
    func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey:  UserDefaultKey.name)
    }
    
    func getUserName() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKey.name) ?? ""
    }
    
    func saveAvatarUrl(_ url: String) {
        UserDefaults.standard.set(url, forKey:  UserDefaultKey.avatarURL)
    }
    
    func getAvatarUrl() -> String {
        return UserDefaults.standard.string(forKey: UserDefaultKey.avatarURL) ?? ""
    }
    
    func sameUserName(_ name: String) -> Bool {
        return UserDefaults.standard.string(forKey: UserDefaultKey.name) == name
    }
}
