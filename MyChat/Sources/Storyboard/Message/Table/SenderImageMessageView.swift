//
//  SenderImageMessageView.swift
//  MyChat
//
//  Created by dexjoke on 5/4/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit
import SDWebImage

class SenderImageMessageView: MessageTableViewCell {
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgMessage: UIImageView!
    
    override func fillData(data: BaseMessageModel, completion: @escaping () -> Void) {
        guard let model = data as?  ImageMessageModel else{
            return
        }
        imgMessage.sd_setImage(with: URL(string: model.data), placeholderImage: UIImage(named: "placehoder")) { (uiImage, error, cacheType, url) in
            completion()
        }
    }
}
