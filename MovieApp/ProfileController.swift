//
//  Profile.swift
//  MovieApp-master
//
//  Created by Zwart on 6/24/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase
class Profile: UIViewController {
    
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
   
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    
    weak var currentField: UITextField?
    var keyboardFrame: CGRect?
    //var profile: A0UserProfile!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.avatar.layer.cornerRadius = 50
        self.avatar.layer.masksToBounds = true
        self.avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        self.avatar.isUserInteractionEnabled = true
        
        updateUI()
        
        _ = NotificationCenter.default
        //        center.addObserver(self, selector: #selector(ProfileViewController.keyboardShown(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        //        center.addObserver(self, selector: #selector(ProfileViewController.keyboardHidden(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardShown(_ notification: Notification) {
        let info = notification.userInfo!
        self.keyboardFrame = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        self.keyboardFrame = self.view.convert(self.keyboardFrame!, from: nil)
        self.containerHeight.constant = 600 + self.keyboardFrame!.size.height
        if let field = self.currentField {
            self.scrollToField(field, keyboardFrame: self.keyboardFrame!)
        }
    }
    
    func keyboardHidden(_ notification: Notification) {
        self.containerHeight.constant = 600
        self.keyboardFrame = nil
    }
    
    @IBAction func editingBegan(_ sender: AnyObject) {
        self.currentField = sender as? UITextField
        if let field = self.currentField, let frame = self.keyboardFrame {
            self.scrollToField(field, keyboardFrame: frame)
        }
    }
    
    @IBAction func editingEnded(_ sender: AnyObject) {
        self.currentField = nil
    }
    
    @IBAction func nextField(_ sender: AnyObject) {
        let field = sender as! UITextField
        _ = field.tag
        var nextTag = field.tag + 1
        if !(600...603 ~= nextTag) {
            nextTag = 600
        }
        if let next = self.view.viewWithTag(nextTag) as? UITextField, let frame = self.keyboardFrame {
            next.becomeFirstResponder()
            self.scrollToField(next, keyboardFrame: frame)
        }
    }
    
    @IBAction func saveProfile(_ sender: AnyObject) {
        alertSpinnerStart()
        let imageName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profile_images").child("\(imageName).png")
        // Delete the file
        storageRef.delete { error in
            if error != nil {
                // Uh-oh, an error occurred!
            } else {
                // File deleted successfully
            }
        }
        if let uploadData = UIImagePNGRepresentation(self.avatar.image!) {
            
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                
                if let error = error {
                    print(error)
                    self.dismissAllMessage()
                    self.alertOK(message: error as! String, title: "Error")
                    return
                }
                
                if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                    let user = userInfo
                    user.name = self.lastName.text
                    user.email = self.email.text
                    user.address = self.address.text
                    user.birthday = self.birthday.text
                    user.phone = self.phone.text
                    user.profileImageUrl = profileImageUrl
                    TMDb.updateUserInfo(user: user, completionHandler: { (error) in
                        if let error = error {
                            self.dismissAllMessage()
                            self.alertOK(message: error as! String, title: "Error")
                            print(error)
                            return
                        }
                        self.dismissAllMessage()
                        return
                    })
                }
                self.dismissAllMessage()
            })
        }
       
//        let controll = UIAlertController.alertControllerWithTitle(title: "ahoho", message: "some message")
        //present(controll, animated: true, completion: nil)
    }
    
    fileprivate func hideKeyboard() {
        self.currentField?.resignFirstResponder()
    }
    
    fileprivate func scrollToField(_ field: UITextField, keyboardFrame: CGRect) {
        let scrollOffset = self.offsetForFrame(field.frame, keyboardFrame: keyboardFrame)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: scrollOffset), animated: true)
    }
    
    fileprivate func offsetForFrame(_ frame: CGRect, keyboardFrame: CGRect) -> CGFloat {
        let bottom = frame.origin.y + frame.size.height
        let offset = bottom - keyboardFrame.origin.y
        if offset < 0 {
            return 0
        }
        return offset
    }
    
    fileprivate func updateUI() {
        TMDb.fetchUser{ (user, error) in
            if(error != nil) {
                print(error!)
            } else {
                self.lastName.text = user.name
                self.email.text = user.email
                self.address.text = user.address
                self.birthday.text = user.birthday
                self.phone.text = user.phone
                if let url = user.profileImageUrl
                {
                    self.avatar.loadImageUsingCacheWithUrlString(url)
                }
            }
        }
    }
}



