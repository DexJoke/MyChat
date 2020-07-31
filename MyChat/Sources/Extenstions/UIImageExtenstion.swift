//
//  UIImageExtentions.swift
//  MyChat
//
//  Created by dexjoke on 6/21/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit
import FirebaseStorage

extension UIImage {
    func resize(size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}
