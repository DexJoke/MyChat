//
//  ChatManager.swift
//  MyChat
//
//  Created by dexjoke on 6/26/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import UIKit
import FirebaseFirestore
import SwiftyJSON

protocol ChatManagerDelegate {
    func onIncomingMessages(message: BaseMessageModel)
    func onSendMessageSuccess(message: BaseMessageModel)
    func onSendMessageFailed(message: BaseMessageModel)
    func onLoadOldMessages(messages: [BaseMessageModel])
    
    func onMemberJoin(name: String)
    func onMemberOut(name: String)
}

class ChatManager {
    private var delegate: ChatManagerDelegate!
    private var firestore: Firestore
    var data: [BaseMessageModel] = []
    private var lastTime: Double!
    
    init(delegate: ChatManagerDelegate) {
        self.delegate = delegate
        firestore = Firestore.firestore()
        
    }
    
    func loadOldMessage() {
        firestore.collection(ChannelKey.channelName.rawValue).order(by: "time", descending: false).getDocuments() { [unowned self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var listMessage: [BaseMessageModel] = []
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    if  UserManager.instance.sameUserName(data["receiverName"] as! String) {
                        listMessage.append(TextMessageModel(json: JSON(data), identifier: .MyText))
                    } else {
                        listMessage.append(TextMessageModel(json: JSON(data)))
                    }
                    self.lastTime =  (data["time"] as! Double)
                }
                
                self.delegate.onLoadOldMessages(messages: listMessage)
            }
        }
        
    }
    
    func registerListener() {
        firestore.collection(ChannelKey.channelName.rawValue)
            .order(by: "time", descending: false)
            .addSnapshotListener(includeMetadataChanges: true) { [unowned self] (query, error) in
                guard let query = query else {
                    return
                }
                
                for document in query.documents {
                    let data = document.data()

                    let time = data["time"] as! Double
                    if time <= self.lastTime {
                        continue
                    }

                    let senderText: BaseMessageModel!

                    if UserManager.instance.sameUserName(data["receiverName"] as! String) {
                        senderText = TextMessageModel(json: JSON(data), identifier: .MyText)
                    } else {
                        senderText = TextMessageModel(json: JSON(data))
                    }
                    self.lastTime = time

                    self.delegate.onIncomingMessages(message: senderText)
                }
        }
    }
    
    private func createDataMessage(message: String) -> [String: Any] {
        var data: [String: Any] = [:]
        
        data["receiverName"] = UserManager.instance.getUserName()
        data["avatarUrl"] = UserManager.instance.getAvatarUrl()
        data["time"] = Date().timeIntervalSinceReferenceDate
        data["message"] = message
        data["identifier"] = MessageCellIdentifiers.SenderText.rawValue
        data["status"] = MemberStatus.chat.rawValue
        
        return data
    }
    
    func sendMessage(message: String) {
        let data = createDataMessage(message: message)
        
        firestore.collection(ChannelKey.channelName.rawValue).addDocument(data: data) {[unowned self] err in
            if let err = err {
                
            } else {
                
            }
        }
    }
    
}
