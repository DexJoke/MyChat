//
//  SenderMessageModel.swift
//  MyChat
//
//  Created by dexjoke on 5/4/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class TextMessageModel: MessageModel {
    var imgAvatar: String!
    var bgMessage: String!
    var time: String!
    var identifier: MessageCellIdentifiers!

    func getIdentifier() -> MessageCellIdentifiers {
        return self.identifier
    }
}
