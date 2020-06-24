//
//  MockData.swift
//  MyChat
//
//  Created by dexjoke on 5/24/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import Foundation

class MockData {
    static func messages() -> [MessageModel] {
        var list: [MessageModel] = []
        
        for _ in 0 ... 40 {
            list.append(randomItemMessage()!)
        }
        
        return list
    }
    
    public static func randomItemMessage() -> MessageModel? {
        switch Int.random(in: 1 ... 4) {
        case 1:
            return TextMessageModel(imgAvatar: "ic_normal_camera", bgMessage: "ic_left_top_message", time: "", message: "mock sender message", identifier: .SenderText)
        case 2:
            return ImageMessageModel(imgAvatar: "ic_normal_camera", time: "", imgMessage: "img_test2", identifier: .SenderImage)
        case 3:
            return TextMessageModel(imgAvatar: "ic_normal_camera", bgMessage: "ic_left_top_message", time: "", message: "mock my message", identifier: .MyText)
        case 4:
            return ImageMessageModel(imgAvatar: "ic_normal_camera", time: "", imgMessage: "img_test", identifier: .MyImage)
        default:
            return nil
        }
    }
}
