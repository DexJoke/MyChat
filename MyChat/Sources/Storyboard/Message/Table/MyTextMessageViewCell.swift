//
//  MyTextMessageViewCell.swift
//  MyChat
//
//  Created by dexjoke on 5/5/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class MyTextMessageViewCell: MessageTableViewCell {
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var bgMessage: UIImageView!
    
    override func fillData(data: BaseMessageModel) {
        guard let model = data as? TextMessageModel else{
            return
        }
        message.text = model.message
    }
}
