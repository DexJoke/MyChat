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

class MyLoginManager: NSObject {
    weak var window: UIWindow!
    
    public func loginFacebook(vc: UIViewController) {
        let fb = FBSDKLoginKit.LoginManager()
        fb.logOut()
        fb.logIn(permissions: ["public_profile", "email", "user_friends", "user_birthday", "user_gender"], from: vc, handler: { [weak self] (result: LoginManagerLoginResult?, error: Error?)  in
            self!.result(result: result, error: error)
        })
    }
    
    public func googleLogin(window: UIWindow) {
        self.window = window
        GIDSignIn.sharedInstance().clientID = "480771188801-hjpc6trq7phlu6fmlv50idqppbjpstfh.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
//        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    func result(result: LoginManagerLoginResult?, error: Error?) {
        if error != nil {
            // do something
            return
        }
        
        print(result!.declinedPermissions)
        getGraphRequest()
    }
    
    func getGraphRequest() {
        let graphRequest : GraphRequest = GraphRequest(graphPath: "me", parameters: ["fields":"email"])
        graphRequest.start { (connection, result, error) in
            if error != nil {
                return
            }
            
            let res = result as! [String:Any]
            print("res=\(res)")
            
        }
    }
}
extension MyLoginManager: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
    }
}

extension MyLoginManager: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.window!
    }
}
