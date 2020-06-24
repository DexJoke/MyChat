//
//  BasicAlert.swift
//  MyChat
//
//  Created by dexjoke on 6/18/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation
import UIKit

class SimpleAlert {
    private var title: String!
    private var content: String!
    private var closeEvent: () -> Void
    
    init(title: String, content: String, closeEvent: @escaping () -> Void ) {
        self.title = title
        self.content = content
        self.closeEvent = closeEvent
    }
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.closeEvent = {() in}
    }
    
    func show(vc: UIViewController) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: handAction))
        vc.present(alert, animated: true, completion: nil)
    }
    
    private func handAction(action: UIAlertAction) {
        self.closeEvent()
    }
}
