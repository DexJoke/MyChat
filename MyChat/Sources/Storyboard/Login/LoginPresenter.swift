
//
//  LoginPresenter.swift
//  MyChat
//
//  Created by dexjoke on 6/17/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import Firebase

protocol LoginPresenterDelegate {
    func onStartLogin()
    func onLoginSusscess()
    func onLoginFailed(error: String)
}

class LoginPresenter {
    private var delegate: LoginPresenterDelegate!
    
    init(delegate: LoginPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func authentication(email: String, password: String) {
        delegate.onStartLogin()
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            if error != nil {
                self!.handleError(error: error! as NSError)
            } else {
                UserManager.instance.saveUserName(result?.user.email ?? "")
                UserManager.instance.saveId(id: result?.user.uid ?? "")
                self!.delegate.onLoginSusscess()
            }
        }
    }
    
    private func handleError(error: NSError) {
        let err = FIRAuthError(rawValue: error.code)
        self.delegate.onLoginFailed(error: (err?.message())!)
    }
}
