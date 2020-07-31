//
//  ViewUtils.swift
//  MyChat
//
//  Created by dexjoke on 4/28/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class ViewUtils {
    static func loadStoryboardVC<Type> (storyboard: String, identifier: String) -> Type {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! Type
    }
    
    static func loadStoryboardInitialVC<Type>(storyboard: String) -> Type{
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        return storyboard.instantiateInitialViewController() as! Type
    }
    
    static func loadNib<T>(name: String) -> T {
        return UINib(nibName: name, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! T
    }
    
    static func changeRootVC(vc: UIViewController) {
        AppDelegate.shared.window!.rootViewController = vc
    }
}
