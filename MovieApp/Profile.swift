//
//  Profile.swift
//  MovieApp-master
//
//  Created by Zwart on 6/24/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class Profile: UIViewController {

    @IBOutlet weak var photo: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UILabel!
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
        
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "profile")!.draw(in: view.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext();
        self.view.backgroundColor = UIColor(patternImage: image!)
        
        updateUI()
        
        let center = NotificationCenter.default
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
        hideKeyboard()
//        let hud = MBProgressHUD.showHUDAddedTo(self.navigationController?.view, animated: true)
//        hud.mode = .Indeterminate
//        hud.labelText = NSLocalizedString("Saving…", comment: "Saving Profile message")
//        let storage = Application.sharedInstance.storage
//        if let idToken = storage.idToken {
//            Auth0
//                .users(idToken)
//                .update(userMetadata: [
//                    MetadataKeys.GivenName.rawValue: self.firstName.text!,
//                    MetadataKeys.FamilyName.rawValue: self.lastName.text!,
//                    MetadataKeys.Address.rawValue: self.address.text!,
//                    MetadataKeys.Birthday.rawValue: self.birthday.text!,
//                    ])
//                .responseJSON { _, profileJSON in
//                    if profileJSON != nil {
//                        let newProfile = A0UserProfile(dictionary: profileJSON!)
//                        storage.profile = newProfile
//                        self.profile = newProfile
//                        let checkImageView = UIImageView(image: UIImage(named: "checkmark"))
//                        hud.customView = checkImageView
//                        hud.mode = .CustomView
//                        hud.labelText = NSLocalizedString("Saved!", comment: "Saved Profile message")
//                        hud.hide(true, afterDelay: 0.8)
//                    } else {
//                        let checkImageView = UIImageView(image: UIImage(named: "cross"))
//                        hud.customView = checkImageView
//                        hud.mode = .CustomView
//                        hud.labelText = NSLocalizedString("Failed!", comment: "Failed Save Profile message")
//                        hud.hide(true, afterDelay: 0.8)
//                    }
//            }
//        }
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
//        self.title = self.profile.name
//        self.avatar.setImageWithURL(self.profile.picture)
//        self.firstName.text = self.profile.firstName
//        self.lastName.text = self.profile.lastName
//        self.email.text = self.profile.email
//        self.address.text = self.profile.userMetadata["address"] as? String
//        self.birthday.text = self.profile.userMetadata["birthday"] as? String
    }

}
