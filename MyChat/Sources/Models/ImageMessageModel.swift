//
//  SenderImageModle.swift
//  MyChat
//
//  Created by dexjoke on 5/24/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import SwiftyJSON

class ImageMessageModel: BaseMessageModel, JsonParse {
    var receiverName: String
    var avatarURL: String!
    var time: String!
    var imageURL: String!
    var identifier: MessageCellIdentifiers!
    
    init(json: JSON, identifier: MessageCellIdentifiers) {
        self.receiverName = json["receiverName"].stringValue
        self.avatarURL = json["avatarUrl"].stringValue
        self.time = json["time"].stringValue
        self.imageURL = json["message"].stringValue
        self.identifier = identifier
    }
    
    required init(json: JSON) {
        self.receiverName = json["receiverName"].stringValue
        self.avatarURL = json["avatarUrl"].stringValue
        self.time = json["time"].stringValue
        self.imageURL = json["message"].stringValue
        self.identifier = MessageCellIdentifiers(rawValue: json["identifier"].stringValue)
    }
    
    func getIdentifier() -> MessageCellIdentifiers {
        return self.identifier
    }
}
