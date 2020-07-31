//
//  IncomeingMessageAlert.swift
//  MyChat
//
//  Created by dexjoke on 7/13/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

protocol IncomeingMessageAlertDelegate {
    func onNewMessageAlertPressed()
}

class IncomeingMessageAlert: UIView {
    @IBOutlet weak var viewContrainer: UIView!
    var delegate: IncomeingMessageAlertDelegate?
    
    static func loadFromNib() -> IncomeingMessageAlert {
        return ViewUtils.loadNib(name: "IncomeingMessageAlert")
    }
    
    override func awakeFromNib() {
        viewContrainer.alpha = 0
        viewContrainer.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        viewContrainer.layer.cornerRadius = viewContrainer.frame.height * 0.5
    }
 
    func show() {
        UIView.animate(withDuration: 0.2, animations: {
            self.viewContrainer.alpha = 1
            self.viewContrainer.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
    
    func hidden() {
        UIView.animate(withDuration: 0.2, animations: {
            self.viewContrainer.alpha = 0
            self.viewContrainer.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
    }
    
    @IBAction func onPressAlert(_ sender: Any) {
        if delegate != nil {
            delegate?.onNewMessageAlertPressed()
        }
        hidden()
    }
}
