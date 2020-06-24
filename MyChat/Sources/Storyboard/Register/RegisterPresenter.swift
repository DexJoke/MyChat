//
//  RegisterPresenter.swift
//  MyChat
//
//  Created by dexjoke on 6/17/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import Firebase

protocol RegisterPresenterDelegate {
    func onStartRegister()
    func onRegisterSuccess()
    func onRegisterFailed(error: String)
}

class RegisterPresenter: BasePresenter {
    private var delegate: RegisterPresenterDelegate!
    let storage: Storage!
    
    init(delegate: RegisterPresenterDelegate) {
        self.delegate = delegate
        storage = Storage.storage(url:"gs://mychat-278816.appspot.com/")
    }
    
    public func createUser(email: String, password: String) {
        delegate.onStartRegister()
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            if error != nil {
                self!.handleError(error: error! as NSError)
            } else {
                self!.delegate.onRegisterSuccess()
            }
        }
    }
    
    private func handleError(error: NSError) {
        let err = FIRAuthError(rawValue: error.code)
        self.delegate.onRegisterFailed(error: (err?.message())!)
    }
}
