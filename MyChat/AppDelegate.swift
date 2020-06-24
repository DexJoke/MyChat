//
//  AppDelegate.swift
//  MyChat
//
//  Created by dexjoke on 4/21/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import GoogleSignIn
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var shared : AppDelegate {return UIApplication.shared.delegate as! AppDelegate}
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        FirebaseApp.configure()

        self.createWindow()
        return true
    }
    
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        
        let facebook = ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
        
        let google = GIDSignIn.sharedInstance().handle(url)
        
        return facebook || google
    }
    
    private func createWindow() {
        self.window = UIWindow()
        print(UserManager.instance.isLogin())
        if UserManager.instance.isLogin() {
            ViewUtils.changeRootVC(vc: ViewUtils.loadStoryboardInitialVC(storyboard: "Message"))
        } else {
            ViewUtils.changeRootVC(vc: ViewUtils.loadStoryboardInitialVC(storyboard: "Artboard"))
        }
        self.window!.makeKeyAndVisible()
    }
    
    // MARK: UISceneSession Lifecycle
}
