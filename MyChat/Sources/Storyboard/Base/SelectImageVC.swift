//
//  SelectImageVC.swift
//  MyChat
//
//  Created by dexjoke on 7/12/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import UIKit
import Photos

class SelectImageVC: BaseVC {
    private weak var controller: UIImagePickerController?
    
    func selectImageFromCamera() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            present(sourceType: .camera)
        } else {
            showAlertOpenSetting(targetName: "Cammera")
        }
    }
    
    func selectImageFromGallery() {
        PHPhotoLibrary.requestAuthorization { (status) in
            DispatchQueue.main.async { [weak self] in
                if status == .authorized {
                    self?.present(sourceType: .photoLibrary)
                } else {
                    self?.showAlertOpenSetting(targetName: "Photo Library")
                }
            }
        }
    }
    
    func onSelectImageSuccess(image: UIImage) {
        
    }
    
    func onSelectImageFailed() {
        
    }
    
    private func present(sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = sourceType
            controller.allowsEditing = true
            self.controller = controller
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    private func dismiss() { controller?.dismiss(animated: true, completion: nil) }
    
    private func showAlertOpenSetting(targetName: String) {
        let alertVC = UIAlertController(title: "Access to the \(targetName)",
            message: "Please provide access to your \(targetName)",
            preferredStyle: .alert)
        
        alertVC.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
            guard   let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(settingsUrl) else { return }
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: { bool in
                print(bool)
            })
        }))
        
        alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        UIApplication.shared.delegate?.window??.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
}

extension SelectImageVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss()
        if let image = info[.editedImage] as? UIImage {
            onSelectImageSuccess(image: image)
            return
        }
        
        if let image = info[.originalImage] as? UIImage {
            onSelectImageSuccess(image: image)
            return
        }
        
        onSelectImageFailed()
    }
}
