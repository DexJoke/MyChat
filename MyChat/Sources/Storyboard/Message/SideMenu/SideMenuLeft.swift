//
//  SideMenu.swift
//  MyChat
//
//  Created by dexjoke on 7/10/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class SideMenuLeft: BaseVC {
    static func create() -> SideMenuLeft {
        let vc: SideMenuLeft = ViewUtils.loadStoryboardVC(storyboard: "SideMenuLeft", identifier: "SideMenuLeft")
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
