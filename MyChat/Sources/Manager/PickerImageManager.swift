//
//  UploadPhotoManager.swift
//  MyChat
//
//  Created by dexjoke on 6/12/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import UIKit
import Photos

protocol PickerImageDelegate {
    func canUseCamera(accessIsAllowed: Bool)
    func canUseGallery(accessIsAllowed: Bool)
    func didSelect(image: UIImage)
    func didCancle()
}

class PickerImageManager: NSObject {
    private weak var controller: UIImagePickerController?
    private var delegate: PickerImageDelegate!
    
    init(delegate: PickerImageDelegate) {
        self.delegate = delegate
    }
    
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        DispatchQueue.main.async {
            let controller = UIImagePickerController()
            controller.delegate = self
            controller.sourceType = sourceType
            controller.allowsEditing = true
            self.controller = controller
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    func dismiss() { controller?.dismiss(animated: true, completion: nil) }
    
    
    private func showAlert(targetName: String, completion: @escaping (Bool)->()) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alertVC = UIAlertController(title: "Access to the \(targetName)",
                message: "Please provide access to your \(targetName)",
                preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
                guard   let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(settingsUrl) else { completion(false); return }
                UIApplication.shared.open(settingsUrl, options: [:]) {
                    [weak self] _ in self?.showAlert(targetName: targetName, completion: completion)
                }
            }))
            
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion(false) }))
            UIApplication.shared.delegate?.window??.rootViewController?.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func cameraAsscessRequest() {
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            self.delegate.canUseCamera(accessIsAllowed: true)
        } else {
            self.showAlert(targetName: "camera") {
                self.delegate?.canUseCamera(accessIsAllowed: $0)
            }
        }
    }
    
    func photoGalleryAsscessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] (status) in
            if status == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.delegate.canUseGallery(accessIsAllowed: true)
                }
            } else {
                self!.showAlert(targetName: "photo") {
                    self!.delegate?.canUseGallery(accessIsAllowed: $0)
                }
            }
        }
    }
}

extension PickerImageManager: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate.didCancle()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.didSelect(image: image)
            return
        }
        
        if let image = info[.originalImage] as? UIImage {
            delegate?.didSelect(image: image)
        } else {
            print("Other source")
        }
    }
}
