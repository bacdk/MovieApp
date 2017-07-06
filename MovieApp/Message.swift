//
//  Message.swift
//  MovieApp-master
//
//  Created by Zwart on 7/3/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    //Message alert
    func alertOK(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: Alert Related Methods
    func showAlert(text : NSString, title : NSString, fn:@escaping ()->Void){
        let alert = UIAlertController(title: title as String, message: text as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in fn()}))
        UIApplication.shared.delegate?.window!?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    func switchToMainStoryboard() ->Void{
        let main = UIStoryboard(name: "Main", bundle: nil)
        let viewController = main.instantiateInitialViewController()!
        viewController.modalTransitionStyle = UIModalTransitionStyle.coverVertical
        self.present(viewController, animated: true, completion: nil)
    }
    func alertSpinnerStart()
    {
        
        let alertSpinnerController = UIAlertController(title: nil, message: "Please wait\n\n", preferredStyle: UIAlertControllerStyle.alert)
        
        let spinnerIndicator: UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        
        spinnerIndicator.center = CGPoint(x: 135.0, y: 65.5)
        spinnerIndicator.color = UIColor.black
        spinnerIndicator.startAnimating()
        
        alertSpinnerController.view.addSubview(spinnerIndicator)
        self.present(alertSpinnerController, animated: false, completion: nil)
    }
    func dismissAllMessage()    {
        self.dismiss(animated: true, completion: nil)
    }
}

//showAlert(text: "You will now be logged in", title: "Account created", fn: {self.switchToMainStoryboard()})

