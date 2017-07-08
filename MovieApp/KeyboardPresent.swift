//
//  KeyboardPresent.swift
//  MovieApp-master
//
//  Created by Zwart on 7/8/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

//Scroll View with tag 200
import Foundation
import UIKit
extension UIViewController {
    
    func keyboardDidShow(notification: NSNotification) {
        let scrollView = self.view.viewWithTag(200) as? UIScrollView
        if  let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            scrollView?.contentInset = contentInsets
            scrollView?.scrollIndicatorInsets = contentInsets
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let scrollView = self.view.viewWithTag(200) as? UIScrollView
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    
    func dismissKeyboard()
    {
        let scrollView = self.view.viewWithTag(200) as? UIScrollView
        for view in (scrollView?.subviews)! {
            if let textField = view as? UITextField {
                textField.resignFirstResponder()
            }
        }
    }
}
