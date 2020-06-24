//
//  SenderMessageCell.swift
//  MyChat
//
//  Created by dexjoke on 5/4/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class SenderTextMessageViewCell: MessageTableViewCell {
    @IBOutlet weak var txtMessage: UILabel!
    @IBOutlet weak var bgMessage: UIImageView!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    override func fillData(data: MessageModel) {
        guard let model = data as? TextMessageModel else {
            return
        }
        
        self.txtMessage.text = model.message
        self.bgMessage.image = UIImage(named: model.bgMessage)
        self.imgAvatar.image = UIImage(named: model.imgAvatar)
    }
}
