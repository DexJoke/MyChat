//
//  ImageCell.swift
//  MyChat
//
//  Created by dexjoke on 6/30/20.
//  Copyright © 2020 Anhnt2. All rights reserved.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgContent: UIImageView!
    
    private var isSelect = false
    var myLayer: CALayer!
    
    override func awakeFromNib() {
        myLayer = CALayer()
        myLayer.position = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)
        myLayer.bounds = CGRect(x: 0,y: 0,width: containerView.frame.size.width,height: containerView.frame.size.height)
        containerView.layer.addSublayer(myLayer)
    }
    
    func update(img: UIImage) {
        imgContent.image = img
    }
    
    @IBAction func onPress(_ sender: Any) {
        toggleItem()
    }
    
    func toggleItem() {
        if isSelect {
            isSelect = false
            myLayer.sublayers?.removeAll()
        } else {
            isSelect = true
            
            let layer = CAShapeLayer()
            let path = UIBezierPath(roundedRect: containerView.frame, cornerRadius: 0)
            layer.path = path.cgPath
            layer.fillColor = nil
            layer.lineWidth = 5
            layer.strokeColor = UIColor.blue.cgColor
            
            myLayer.addSublayer(layer)
        }
    }
}
