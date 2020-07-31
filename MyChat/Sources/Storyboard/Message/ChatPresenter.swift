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

protocol ChatPresenterDelegate {
    func onIncomingMessages(message: BaseMessageModel)
    func onSendMessageSuccess(message: BaseMessageModel)
    func onSendMessageFailed(message: BaseMessageModel)
    func onLoadOldMessages(messages: [BaseMessageModel])
    
    func onMemberJoin(name: String)
    func onMemberOut(name: String)
}

class ChatPresenter {
    private var delegate: ChatPresenterDelegate!
    private var firestore: Firestore
    private var lastTime: Double = 0.0
    private var storageImageManager: StorageImageManager!
    
    init(delegate: ChatPresenterDelegate) {
        self.delegate = delegate
        firestore = Firestore.firestore()
        storageImageManager = StorageImageManager(delegate: self)
    }
    
    func loadOldMessage() {
        firestore.collection(ChannelKey.channelName.rawValue).order(by: "time", descending: false).getDocuments() { [unowned self] (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var listMessage: [BaseMessageModel] = []
                
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let message = self.generateMessageModel(json: JSON(data))
                    listMessage.append(message)
                    self.lastTime =  (data["time"] as! Double)
                }
                
                self.delegate.onLoadOldMessages(messages: listMessage)
            }
        }
    }
    
    func registerIncomingMessages() {
        firestore.collection(ChannelKey.channelName.rawValue)
            .order(by: "time", descending: false)
            .addSnapshotListener(includeMetadataChanges: true) { [unowned self] (query, error) in
                guard let query = query else {
                    return
                }
                
                for document in query.documents {
                    let data = document.data()
                    
                    if !self.isNewMessage(data: data) {
                        continue
                    }
                    
                    let senderText = self.generateMessageModel(json: JSON(data))
                    self.delegate.onIncomingMessages(message: senderText)
                    self.lastTime = data["time"] as! Double
                }
        }
    }
    
    private func generateMessageModel(json: JSON) -> BaseMessageModel{
        if json["type"].intValue == MessageType.text.rawValue {
            return generateTextMessage(json: json)
        } else {
            return generateImageMessage(json: json)
        }
    }
    
    private func generateTextMessage(json: JSON) -> BaseMessageModel {
        if UserManager.instance.sameUserName(json["sender"]["name"].stringValue) {
            return TextMessageModel(json: json, identifier: .MyText)
        } else {
            return TextMessageModel(json: json, identifier: .SenderText)
        }
    }
    
    private func generateImageMessage(json: JSON) -> BaseMessageModel {
        if UserManager.instance.sameUserName(json["sender"]["name"].stringValue) {
            return ImageMessageModel(json: json, identifier: .MyImage)
        } else {
            return ImageMessageModel(json: json, identifier: .SenderImage)
        }
    }
    
    private func isNewMessage(data: [String: Any]) -> Bool{
        let time = data["time"] as! Double
        return time > self.lastTime
    }
    
    private func createDataMessage(message: String, type: MessageType) -> [String: Any] {
        return [
            "sender" : [
                "id" : UserManager.instance.getId(),
                "name" : UserManager.instance.getUserName(),
                "avatarUrl" : UserManager.instance.getAvatarUrl()
            ],
            "data" : message,
            "type" : type.rawValue,
            "time" : Date().timeIntervalSinceReferenceDate
        ]
    }
    
    func sendImage(image: UIImage) {
        storageImageManager.upload(image: image, path: .images)
    }
    
    func sendTextMessage(message: String) {
        sendMessage(message: message, type: .text)
    }
    
    func sendMessage(message: String, type: MessageType) {
        let data = createDataMessage(message: message, type: type)
        firestore.collection(ChannelKey.channelName.rawValue).addDocument(data: data) {[unowned self] err in
            let senderText = self.generateMessageModel(json: JSON(data))
            if let err = err {
                self.delegate.onSendMessageFailed(message: senderText)
                return
            }
            
            self.delegate.onSendMessageSuccess(message: senderText)
        }
    }
    
}

extension ChatPresenter: StorageImageDelegate {
    func onStartUpLoad() {
        
    }
    
    func onUpLoadSuccess(imageURL: String) {
        sendMessage(message: imageURL, type: .image)
    }
    
    func onUpLoadFailed(error: String) {
        print(error)
    }
}
