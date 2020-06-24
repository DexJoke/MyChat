//
//  SenderImageModle.swift
//  MyChat
//
//  Created by dexjoke on 5/24/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation

struct ImageMessageModle: MessageModel {
    var imgAvatar: String!
    var time: String!
    var imgMessage: String!
    var identifier: MessageCellIdentifiers!
    
    func getIdentifier() -> MessageCellIdentifiers {
        return self.identifier
    }
}
