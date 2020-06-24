//
//  MessageModel.swift
//  MyChat
//
//  Created by dexjoke on 5/24/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation

enum MessageCellIdentifiers: String {
    case SenderText
    case SenderImage
    case MyText
    case MyImage
    
    func value() -> String {
        switch self {
        case .SenderText : return "senderText"
        case .SenderImage : return "senderImage"
        case .MyText : return "myText"
        case .MyImage : return "myImage"
        }
    }
}

protocol MessageModel {
    func getIdentifier() -> MessageCellIdentifiers
}
