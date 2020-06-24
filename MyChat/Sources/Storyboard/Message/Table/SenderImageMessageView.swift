//
//  SenderImageMessageView.swift
//  MyChat
//
//  Created by dexjoke on 5/4/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class SenderImageMessageView: MessageTableViewCell {
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var imgMessage: UIImageView!
    
    override func fillData(data: MessageModel) {
        guard let model = data as?  ImageMessageModel else{
            return
        }
        
        self.imgAvatar.image = UIImage(named: model.imgAvatar)
        self.imgMessage.image = UIImage(named: model.imgMessage)

    }
}
