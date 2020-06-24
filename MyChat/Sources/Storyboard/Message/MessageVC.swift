//
//  MessageVC.swift
//  MyChat
//
//  Created by dexjoke on 5/1/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class MessageVC: BaseVC {
    @IBOutlet weak var tblMessage: UITableView!
    
    @IBOutlet weak var constraintsBottomButtonViewContainer: NSLayoutConstraint!
    
    override var isEnableBack: Bool { return false }
    override var isExistNavi: Bool { return false }
    let data: [MessageModel] = MockData.messages()
    
    static func create() -> MessageVC {
        return ViewUtils.loadStoryboardVC(storyboard: "Message", identifier: "MessageVC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblMessage.delegate = self
        self.tblMessage.dataSource = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        handleKeyboardChange(notification)
    }
    
    @objc func keyBoardWillHide(notification: NSNotification) {
        handleKeyboardChange(notification)
    }
    
    private func handleKeyboardChange(_ notification: NSNotification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
               return
           }

           let keyboardHeight: CGFloat
           if #available(iOS 11.0, *) {
               keyboardHeight = keyboardFrame.cgRectValue.height - self.view.safeAreaInsets.bottom
           } else {
               keyboardHeight = keyboardFrame.cgRectValue.height
           }
        
        let duration:TimeInterval = (notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let isShowing = notification.name == UIResponder.keyboardWillShowNotification
        constraintsBottomButtonViewContainer.constant = isShowing ? keyboardHeight : 0

        UIView.animate(withDuration: duration, delay: TimeInterval(0),animations: { self.view.layoutIfNeeded()
        })
    }
}

extension MessageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.getIdentifier().value()) as! MessageTableViewCell
        print(item.getIdentifier().value())
        cell.fillData(data: item)
        return cell
    }
    
    
}
