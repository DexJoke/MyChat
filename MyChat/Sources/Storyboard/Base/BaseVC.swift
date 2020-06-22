//
//  BaseVC.swift
//  MyChat
//
//  Created by dexjoke on 4/28/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit
import JGProgressHUD

class BaseVC: UIViewController, UIGestureRecognizerDelegate {
    private(set) var hasViewWillAppear = false
    private(set) var hasViewDidAppear = false
    private(set) var hasPop = false
    var isEnableBack: Bool {return true}
    var isExistNavi: Bool {return true}
    var titleNavigation: String {return ""}
    
    let hud = JGProgressHUD(style: .dark)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !hasViewWillAppear {
            self.createBackButton()
        }
        
        if let navigationController = self.navigationController {
            navigationController.navigationBar.isHidden = !isExistNavi
            navigationController.navigationBar.isTranslucent = false
            self.navigationItem.title = titleNavigation
            
            navigationController.navigationBar.barStyle = .black
            navigationController.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        }
        
        self.hasViewWillAppear = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.enableSwipeBack()
        self.hasViewDidAppear = true
    }
    
    func createBackButton() {
        if (navigationController?.viewControllers.count ?? 0) <= 1 && navigationController?.topViewController == self {
            return
        }
        
        if !isEnableBack {
            return
        }
        let barButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back")!.withRenderingMode(.alwaysOriginal) , style: .plain, target: self, action: #selector(BaseVC.pushedBackButton))
        self.navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func pushedBackButton() {
        if self.hasPop { return }
        if self.backEvent() {
            self.popVC()
        }
    }
    
    func backEvent() -> Bool { return true }
    
    
    func enableSwipeBack() {
        guard let navigationController = self.navigationController else { return }
        let isEnabled = self.isEnableBack && navigationController.viewControllers.first !== self
        navigationController.interactivePopGestureRecognizer?.isEnabled = isEnabled
        navigationController.interactivePopGestureRecognizer?.delegate = isEnabled ? self : nil
        navigationController.interactivePopGestureRecognizer?.addTarget(self, action: #selector(BaseVC.swipeBack))
    }
    
    @objc func swipeBack() {   }
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
        self.hasPop = true
    }
    
    func pushVC(vc: BaseVC, animate: Bool = true) {
        self.navigationController?.pushViewController(vc, animated: animate)
    }
    
    func showLoading() {
        hud.vibrancyEnabled = true
        hud.textLabel.text = "Loading"
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.2)
        hud.show(in: (AppDelegate.shared.window?.rootViewController!.view)!)
    }
    
    func hideLoading() {
        hud.dismiss()
    }
}
