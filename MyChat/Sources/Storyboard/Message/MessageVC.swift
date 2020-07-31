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
import SideMenu
import SnapKit

class MessageVC: SelectImageVC {
    @IBOutlet weak var tblMessage: UITableView!
    @IBOutlet weak var constraintsBottomButtonViewContainer: NSLayoutConstraint!
    @IBOutlet weak var editMessage: UITextField!
    @IBOutlet weak var tableViewContainer: UIView!
    
    override var isEnableBack: Bool { return false }
    private var chatPresenter: ChatPresenter!
    private var listMessage: [BaseMessageModel] = []
    private var alert: IncomeingMessageAlert!

    static func create() -> MessageVC {
        return ViewUtils.loadStoryboardVC(storyboard: "Message", identifier: "MessageVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblMessage.delegate = self
        self.tblMessage.dataSource = self
        chatPresenter = ChatPresenter(delegate: self)
        chatPresenter.loadOldMessage()
        createIncomeingMessageAlert()

    }
    
    private func createIncomeingMessageAlert() {
        alert = IncomeingMessageAlert.loadFromNib()
        alert.delegate = self
        tableViewContainer.addSubview(alert)
        alert.snp.makeConstraints { (make) -> Void in
            make.bottom.bottomMargin.equalTo(tableViewContainer)
            make.centerX.equalTo(tableViewContainer)
        }
    }
    
    override func onSelectImageSuccess(image: UIImage) {
        chatPresenter.sendImage(image: image.resize(size: CGSize(width: 300, height: 200)))
    }
    
    override func onSelectImageFailed() {
        
    }
    
    @IBAction func handleSendMessage(_ sender: Any) {
        if let message = editMessage.text {
            chatPresenter.sendTextMessage(message: message)
        }
    }
    
    @IBAction func handleSendImageFromGallery(_ sender: Any) {
        selectImageFromCamera()
    }
    
    @IBAction func handleSendImageUsingCamera(_ sender: Any) {
        selectImageFromCamera()
    }
    
    @IBAction func onPressBackButton(_ sender: Any) {
        
    }
    
    override func keyboardChange(_ isShow: Bool, _ heightKeyboard: Float, _ heightTabBar: Float, _ heighSafeArea: Float) {
        let contrainsUpdate = heightKeyboard - heighSafeArea - heightTabBar
        constraintsBottomButtonViewContainer.constant = CGFloat(isShow ? contrainsUpdate : 0)
    }
    
    private func scrollToLastItem() {
        if listMessage.count - 1 > 0 {
            tblMessage.scrollToRow(at: IndexPath(item: listMessage.count - 1, section: 0), at: .bottom, animated: true)
            print("scrollToLastItem = \(tblMessage.contentOffset.y)")
            
        }
    }
}

extension MessageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = listMessage[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.getIdentifier().rawValue) as! MessageTableViewCell
        cell.fillData(data: item, completion: {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        })
        print(tableView.contentOffset.y)
        
        return cell
    }
}

extension MessageVC: ChatPresenterDelegate {
    func onLoadOldMessages(messages: [BaseMessageModel]) {
        print("onLoadOldMessages")
        self.listMessage = messages
        UIView.animate(withDuration: 0, animations: {
            self.tblMessage.reloadData()
        }) { _ in
            self.scrollToLastItem()
            self.chatPresenter.registerIncomingMessages()
        }
    }
    
    func onIncomingMessages(message: BaseMessageModel) {
        print("onIncomingMessages")
        if tblMessage.indexPathsForVisibleRows?.last?.row == listMessage.count - 1 {
            listMessage.append(message)
            tblMessage.insertRows(at: [IndexPath(item: listMessage.count - 1, section: 0)], with: .top)
            scrollToLastItem()
        } else {
            listMessage.append(message)
            tblMessage.insertRows(at: [IndexPath(item: listMessage.count - 1, section: 0)], with: .top)
            alert.show()
        }
        
    }
    
    func onSendMessageSuccess(message: BaseMessageModel) {
        print("onSendMessageSuccess")
    }
    
    func onSendMessageFailed(message: BaseMessageModel) {
        print("onSendMessageFailed")
    }
    
    func onMemberJoin(name: String) {
        print("onMemberJoin")
    }
    
    func onMemberOut(name: String) {
        print("onMemberOut")
    }
    
}

extension MessageVC: IncomeingMessageAlertDelegate {
    func onNewMessageAlertPressed() {
        scrollToLastItem()
    }
}
