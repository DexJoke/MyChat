//
//  LoginManager.swift
//  MyChat
//
//  Created by dexjoke on 6/2/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import GoogleSignIn
import AuthenticationServices
import Firebase

protocol ArtboardPresenterDelegate {
    func onLoginSuccess()
    func onLoginFail(error: String)
    func onStrartLogin()
}

class ArtboardPresenter: NSObject {
    private var delegate: ArtboardPresenterDelegate!
    private let facebookPermissions = ["public_profile", "email", "user_friends", "user_birthday", "user_gender"]
    private let clientID = "480771188801-hjpc6trq7phlu6fmlv50idqppbjpstfh.apps.googleusercontent.com"
    
    init(delegate: ArtboardPresenterDelegate) {
        self.delegate = delegate
    }
    
    public func facebookLogin() {
        guard let vc = delegate as? UIViewController else {
            return
        }
        
        let fb = FBSDKLoginKit.LoginManager()
        fb.logIn(permissions: facebookPermissions, from: vc, handler: handleFacebookLogin)
    }
    
    public func googleLogin() {
        guard let vc = delegate as? UIViewController else {
            return
        }
        
        GIDSignIn.sharedInstance().clientID = clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = vc
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    private func handleFacebookLogin(result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            delegate.onLoginFail(error: error.debugDescription)
        } else {
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            self.authenWithFirebase(credential: credential)
        }
    }
    
    private func authenWithFirebase(credential: AuthCredential) {
        delegate.onStrartLogin()
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if error != nil {
                self.delegate.onLoginFail(error: error.debugDescription)
            } else {
                self.delegate.onLoginSuccess()
            }
        }
    }
}


// MARK: GIDSignInDelegate
extension ArtboardPresenter: GIDSignInDelegate {
    private func saveProfileUser(user: GIDGoogleUser!) {
        UserManager.instance.saveUserName(user.profile.name ?? "")
        UserManager.instance.saveAvatarUrl(user.profile.imageURL(withDimension: 100)?.absoluteString ?? "")
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if user == nil {
            return
        }
        
        if error != nil {
            delegate.onLoginFail(error: error.debugDescription)
        } else {
            guard let authentication = user.authentication else { return }
            
            saveProfileUser(user: user)
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
            authenWithFirebase(credential: credential)
        }
    }
}
