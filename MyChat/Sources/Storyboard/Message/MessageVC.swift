//
//  MessageVC.swift
//  MyChat
//
//  Created by dexjoke on 5/1/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class MessageVC: BaseVC {
    @IBOutlet weak var tblMessage: UITableView!
    @IBOutlet weak var constraintsBottomButtonViewContainer: NSLayoutConstraint!
    @IBOutlet weak var editMessage: UITextField!
    
    override var isEnableBack: Bool { return false }
    override var isExistNavi: Bool { return false }
    var chatManager: ChatManager!
    var listMessage: [BaseMessageModel] = []
    
    static func create() -> MessageVC {
        return ViewUtils.loadStoryboardVC(storyboard: "Message", identifier: "MessageVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblMessage.delegate = self
        self.tblMessage.dataSource = self
        chatManager = ChatManager(delegate: self)
        chatManager.loadOldMessage()
    }
    
    @IBAction func handleSendMessage(_ sender: Any) {
        if let message = editMessage.text {
            chatManager.sendMessage(message: message)
        }
    }
    
    override func keyboardChange(_ isShow: Bool, _ heightKeyboard: Float, _ heightTabBar: Float, _ heighSafeArea: Float) {
        let contrainsUpdate = heightKeyboard - heighSafeArea - heightTabBar
        constraintsBottomButtonViewContainer.constant = CGFloat(isShow ? contrainsUpdate : 0)
    }
    
    private func scrollToLastItem() {
        tblMessage.scrollToRow(at: IndexPath(item: listMessage.count - 1, section: 0), at: .bottom, animated: true)
    }
}

extension MessageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listMessage[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.getIdentifier().rawValue) as! MessageTableViewCell
        cell.fillData(data: item)
        return cell
    }
}

extension MessageVC: ChatManagerDelegate {
    func onLoadOldMessages(messages: [BaseMessageModel]) {
        self.listMessage = messages
        tblMessage.reloadData()
        chatManager.registerListener()
        scrollToLastItem()
    }
    
    func onIncomingMessages(message: BaseMessageModel) {
        listMessage.append(message)
        tblMessage.insertRows(at: [IndexPath(item: listMessage.count - 1, section: 0)], with: .top)
        scrollToLastItem()
    }
    
    func onSendMessageSuccess(message: BaseMessageModel) {
        
    }
    
    func onSendMessageFailed(message: BaseMessageModel) {
        
    }
    
    func onMemberJoin(name: String) {
        
    }
    
    func onMemberOut(name: String) {
        
    }
    
}
