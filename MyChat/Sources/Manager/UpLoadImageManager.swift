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

protocol UpLoadImageDelegate {
    func onStartUpLoad()
    func onUpLoadSuccess()
    func onUpLoadFailed(error: String)
}

class  StoreImageManager {
    private var delegate: UpLoadImageDelegate!
    let storageRef: StorageReference!

    init() {
//        self.delegate = delegate
        self.storageRef = Storage.storage().reference()
    }
    
    func upload(image: UIImage, path: StorageRefPath) {
        let name = "\(UUID().uuidString).png"
//        print(imag)
        let riversRef = storageRef.child("\(path.rawValue)/\(name)")
        // Upload the file to the path "images/rivers.jpg"
        riversRef.putData(image.pngData()!, metadata: nil) { (metadata, error) in
            print(metadata)
            print(error)
        }
           
    }
}
