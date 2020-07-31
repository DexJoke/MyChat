//
//  UserDefaultManager.swift
//  MyChat
//
//  Created by dexjoke on 6/19/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation

class UserManager {
    private let LOGIN = "login"
    private let NAME = "name"
    private let AVATAR_URL = "avatarURL"
    private let GMAIL = "gmail"
    private let ID = "id"
    
    static let instance  = UserManager()
    
    func saveId(id: String) {
        UserDefaults.standard.set(true, forKey: ID)
    }
    
    func getId() -> String {
        return UserDefaults.standard.string(forKey: ID) ?? ""
    }
    
    func isLogin() -> Bool {
        return UserDefaults.standard.bool(forKey: LOGIN)
    }
    
    func logged() {
        UserDefaults.standard.set(true, forKey: LOGIN)
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: LOGIN)
    }
    
    func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey:  NAME)
    }
    
    func getUserName() -> String {
        return UserDefaults.standard.string(forKey: NAME) ?? ""
    }
    
    func saveAvatarUrl(_ url: String) {
        UserDefaults.standard.set(url, forKey:  AVATAR_URL)
    }
    
    func getAvatarUrl() -> String {
        return UserDefaults.standard.string(forKey: AVATAR_URL) ?? ""
    }
    
    func sameUserName(_ name: String) -> Bool {
        return getUserName() == name
    }
}
