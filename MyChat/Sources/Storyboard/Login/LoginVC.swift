//
//  LoginVC.swift
//  MyChat
//
//  Created by dexjoke on 4/28/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class LoginVC: BaseVC, LoginPresenterDelegate {
    @IBOutlet weak var editUserName: UITextField!
    @IBOutlet weak var editPassword: UITextField!

    override var titleNavigation: String {return "Login"}
    private var presenter: LoginPresenter!
    
    static func create() -> LoginVC {
        return ViewUtils.loadStoryboardVC(storyboard: "Login", identifier: "LoginVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = LoginPresenter(delegate: self)
    }
    
    @IBAction func handleLogin(_ sender: Any) {
        guard let userName = editUserName.text, let password = editPassword.text else {
            return
        }
        
        presenter.authentication(email: userName, password: password)
    }
    
    func onStartLogin() {
        showLoading()
    }
    
    func onLoginSusscess() {
        hideLoading()
        UserManager.instance.logged()
        self.pushVC(vc: MessageVC.create())
    }
    
    func onLoginFailed(error: String) {
        hideLoading()
        SimpleAlert(title: "Alert", content: error).show(vc: self)
    }
}
