//
//  ResetPasswordController.swift
//  MovieApp-master
//
//  Created by Zwart on 7/8/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class ResetPasswordController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var resetTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // For text field
        NotificationCenter.default.addObserver(self, selector: #selector(ResetPasswordController.keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ResetPasswordController.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // for tapping
        self.scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Profile.dismissKeyboard)))
        // Do any additional setup after loading the view.
    }
    
    //
    @IBAction func backAction(_ sender: UIButton) {
        dismissAllMessage()
    }
    
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    //
    @IBAction func resetPasswordAction(_ sender: DesignButton) {
        if resetTextField.text?.characters.count == 0 {
            alertOK(message: "Please enter email!", title: "Error")
        }
        else {
            TMDb.resetPassword(email: resetTextField.text!, completionHandler: { (error) in
                if error != nil {
                    self.statusLabel.text = error?.localizedDescription
                    return
                }
                else {
                    let alert = UIAlertController(title: "Success!", message:   "Please check your email at to verify your password reset instructions", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
                        self.dismissAllMessage()
                    })
                    //Add action OK
                    alert.addAction(OKAction)
                    self.present(alert, animated: true){}
                }
            })
        }
    }
}
