//
//  MyImageMessageViewCell.swift
//  MyChat
//
//  Created by dexjoke on 5/5/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class MyImageMessageViewCell: MessageTableViewCell {
    @IBOutlet weak var imgMessage: UIImageView!
    
    override func fillData(data: MessageModel) {
        guard let model = data as?  ImageMessageModel else{
            return
        }
        
        self.imgMessage.image = UIImage(named: model.imgMessage)
    }
}
