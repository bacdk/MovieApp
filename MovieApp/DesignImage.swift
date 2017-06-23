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
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
