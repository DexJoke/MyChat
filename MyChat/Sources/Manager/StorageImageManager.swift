//
//  UploadImageManager.swift
//  MyChat
//
//  Created by dexjoke on 6/29/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage

enum StorageRefPath: String{
    case images = "images"
    case avatars = "avatars"
}

protocol StorageImageDelegate {
    func onStartUpLoad()
    func onUpLoadSuccess(imageURL: String)
    func onUpLoadFailed(error: String)
}

class  StorageImageManager {
    private var delegate: StorageImageDelegate!
    let storageRef: StorageReference!
    
    init(delegate: StorageImageDelegate) {
        self.delegate = delegate
        self.storageRef = Storage.storage().reference()
    }
    
    func upload(image: UIImage, name: String? = nil, path: StorageRefPath) {
        delegate.onStartUpLoad()
        let imageName: String = name ?? UUID().uuidString
        let riversRef = storageRef.child("\(path.rawValue)/\(imageName).png")
        riversRef.putData(image.pngData()!, metadata: nil) { (metadata, error) in
            if error != nil {
                self.delegate.onUpLoadFailed(error: error.debugDescription)
            } else {
                self.handleUploadImageSuccess(riversRef: riversRef, metaData: metadata!)
            }
        }
    }
    
    private func handleUploadImageSuccess(riversRef: StorageReference,metaData: StorageMetadata) {
        riversRef.downloadURL { (url, error) in
            guard let downloadURL = url else {
                self.delegate.onUpLoadFailed(error: error.debugDescription)
                return
            }
            self.delegate.onUpLoadSuccess(imageURL: downloadURL.absoluteString)
        }
    }
}
