//
//  DesignImage.swift
//  MovieApp-master
//
//  Created by Zwart on 6/23/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
@IBDesignable
class DesignImage: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var masksToBounds: Bool = true {
        didSet{
            layer.masksToBounds = true
        }
    }
}

extension UIImageView {
    //cỉrcle
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setUpImageView() {
        let color = Constants.tintColor
        self.layer.cornerRadius = CGFloat (self.frame.width / 2)
        self.clipsToBounds = true
        self.layer.frame = self.layer.frame.insetBy(dx: 20, dy: 20)
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2.0
    }
    
    func setUpShadow() {
        self.backgroundColor = UIColor.clear
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        self.layer.shouldRasterize = true
    }
    
    func dropShadow(scale: Bool = true) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}


