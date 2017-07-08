//
//  Profile.swift
//  MovieApp-master
//
//  Created by Zwart on 6/24/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase
class Profile: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var birthday: UITextField!
    @IBOutlet weak var containerHeight: NSLayoutConstraint!

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.avatar.layer.cornerRadius = 50
        self.avatar.layer.masksToBounds = true
        self.avatar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView)))
        self.avatar.isUserInteractionEnabled = true
        //self.dele
        updateUI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(Profile.keyboardDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(Profile.keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // for tapping
        self.scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(Profile.dismissKeyboard)))
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



