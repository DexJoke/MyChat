//
//  RegisterVC.swift
//  MyChat
//
//  Created by dexjoke on 4/28/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class RegisterVC: BaseVC {
    @IBOutlet weak var editUserName: UITextField!
    @IBOutlet weak var editPassword: UITextField!
    @IBOutlet weak var editConfirmPassword: UITextField!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    override var titleNavigation: String { return "Register" }
    private var presenter: RegisterPresenter!
    private var pickerImage: PickerImageManager!
    
    static func create() -> RegisterVC {
        return ViewUtils.loadStoryboardVC(storyboard: "Register", identifier: "RegisterVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = RegisterPresenter(delegate: self)
        pickerImage = PickerImageManager(delegate: self)
    }
    
    @IBAction func handleRegister(_ sender: Any) {
        guard let userName = editUserName.text, let password = editPassword.text, let confirmPassword = editConfirmPassword.text else {
            return
        }
        if !validate(userName: userName, password: password, confirmPassword: confirmPassword) {
            return
        }
        
        presenter.createUser(email: userName, password: password)
    }
    
    @IBAction func onPressButtonUploadAvatar(_ sender: Any) {
        showActionSheet()
    }
    
    private func showActionSheet() {
        let alert = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Photo", style: .default, handler: { action in
            self.pickerImage.photoGalleryAsscessRequest()
        }))
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.pickerImage.cameraAsscessRequest()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    private func validate(userName: String, password: String, confirmPassword: String) -> Bool {
        if password != confirmPassword {
            SimpleAlert(title: "Alert", content: "Confirm your password").show(vc: self)
            return false
        }
        
        return true
    }
}

extension RegisterVC: RegisterPresenterDelegate {
    func onStartRegister() {
        showLoading()
    }
    
    func onRegisterSuccess() {
        hideLoading()
        SimpleAlert(title: "Alert", content: "Register Success", closeEvent: { [weak self] in
            self!.pushVC(vc: MessageVC.create())
        }).show(vc: self)
    }
    
    func onRegisterFailed(error: String) {
        SimpleAlert(title: "Alert", content: error).show(vc: self)
    }
}

extension RegisterVC: PickerImageDelegate {
    func canUseCamera(accessIsAllowed: Bool) {
        if accessIsAllowed {
            pickerImage.present(parent: self, sourceType: .camera)
        }
    }
    
    func canUseGallery(accessIsAllowed: Bool) {
        if accessIsAllowed {
            pickerImage.present(parent: self, sourceType: .photoLibrary)
        }
    }
    
    func didSelect(image: UIImage) {
        self.pickerImage.dismiss()
        imgAvatar.image = image.resize(size: CGSize(width: 100, height: 100))
        
    }
    
    func didCancle() {
        print("didCancle")
    }
    
}
