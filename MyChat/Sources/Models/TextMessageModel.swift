//
//  SenderMessageModel.swift
//  MyChat
//
//  Created by dexjoke on 5/4/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit
import SwiftyJSON

class TextMessageModel: BaseMessageModel, JsonParse {
    var receiverName: String!
    var avatarURL: String!
    var bgMessage: String!
    var time: String!
    var message: String!
    var identifier: MessageCellIdentifiers!
    
    required init(json: JSON) {
        self.receiverName = json["receiverName"].stringValue
        self.avatarURL = json["avatarUrl"].stringValue
        self.time = json["time"].stringValue
        self.message = json["message"].stringValue
        self.identifier = MessageCellIdentifiers(rawValue: json["identifier"].stringValue)
    }
    
    init(json: JSON, identifier: MessageCellIdentifiers) {
        self.receiverName = json["receiverName"].stringValue
        self.avatarURL = json["avatarUrl"].stringValue
        self.time = json["time"].stringValue
        self.message = json["message"].stringValue
        self.identifier = identifier
    }
    
    func getIdentifier() -> MessageCellIdentifiers {
        return self.identifier
    }
}
