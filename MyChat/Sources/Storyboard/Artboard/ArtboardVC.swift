//
//  Artboard.swift
//  MyChat
//
//  Created by dexjoke on 4/28/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn

enum ButtonLogin: Int {
    case Login
    case Facebook
    case Google
    case Apple
    case Register
}

class ArtboardVC: BaseVC {
    @IBOutlet weak var buttonLoginContainer: UIStackView!
    
    private var artboardPresenter: ArtboardPresenter!
    override var isExistNavi: Bool { return false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        artboardPresenter = ArtboardPresenter(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear")
        print(buttonLoginContainer)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        switch sender.tag {
        case ButtonLogin.Login.rawValue:
            pushVC(vc: LoginVC.create())
            break
        case ButtonLogin.Facebook.rawValue:
            artboardPresenter.facebookLogin()
            break
        case ButtonLogin.Google.rawValue:
            artboardPresenter.googleLogin()
            break
        case ButtonLogin.Apple.rawValue:
            
            break
        case ButtonLogin.Register.rawValue:
            pushVC(vc: RegisterVC.create())
//            pushVC(vc: MessageVC.create())

            break
        default: break
        }
    }
}

extension ArtboardVC: ArtboardPresenterDelegate {
    func onLoginSuccess() {
        hideLoading()
        UserManager.instance.logged()
        pushVC(vc: MessageVC.create())
    }
    
    func onLoginFail(error: String) {
        SimpleAlert(title: "Thông báo lỗi", content: "Login thất bại \(error)").show(vc: self)
        hideLoading()
    }
    
    func onStrartLogin() {
        showLoading()
    }
}
