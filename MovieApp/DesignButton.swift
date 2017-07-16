//
//  DetailController.swift
//  MovieApp-master
//
//  Created by Tai Nhat Huynh on 6/10/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

@IBDesignable
class DesignButton: UIButton {

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
}

//Format fir button
extension UIButton
{
    func setUpLayer(sampleButton: UIButton?) {
        sampleButton?.tintColor =  UIColor.white
        sampleButton!.frame = CGRect(x:50, y:500, width:170, height:40)
        sampleButton!.layer.borderWidth = 1.0
        sampleButton!.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        sampleButton!.layer.cornerRadius = 5.0
        sampleButton!.layer.shadowRadius =  3.0
        sampleButton!.layer.shadowColor =  UIColor.white.cgColor
        sampleButton!.layer.shadowOpacity =  0.3
    }
    
}
