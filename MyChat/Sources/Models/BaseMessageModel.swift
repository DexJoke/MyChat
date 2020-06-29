//
//  MessageModel.swift
//  MyChat
//
//  Created by dexjoke on 5/24/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation

enum MessageCellIdentifiers: String {
    case SenderText = "senderText"
    case SenderImage = "senderImage"
    case MyText = "myText"
    case MyImage = "myImage"
}

enum MessageType: Int {
    case text = 1
    case image = 2
}

enum MemberStatus: Int {
    case joinChannel = 1
    case chat = 2
    case outChannel = 3
}

protocol BaseMessageModel {
    func getIdentifier() -> MessageCellIdentifiers
}
