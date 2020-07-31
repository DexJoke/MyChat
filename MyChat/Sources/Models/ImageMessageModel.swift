//
//  SenderImageModle.swift
//  MyChat
//
//  Created by dexjoke on 5/24/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import SwiftyJSON

class ImageMessageModel: BaseMessageModel {
    var receiverName: String!
    var avatarURL: String!
    var bgMessage: String!
    var time: String!
    var data: String!
    var identifier: MessageCellIdentifiers!
    var type: MessageType!
    
    init(json: JSON, identifier: MessageCellIdentifiers) {
        self.receiverName = json["sender"]["name"].stringValue
        self.avatarURL = json["avatarUrl"].stringValue
        self.time = json["time"].stringValue
        self.data = json["data"].stringValue
        self.identifier = identifier
    }
    
    func getIdentifier() -> MessageCellIdentifiers {
        return self.identifier
    }
}
