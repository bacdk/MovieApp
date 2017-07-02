//
//  Profile.swift
//  MovieApp-master
//
//  Created by Zwart on 6/24/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

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
        let user = userInfo
        user.name = self.lastName.text
        user.email = self.email.text
        user.address = self.address.text
        user.birthday = self.birthday.text
        user.phone = self.phone.text
        TMDb.updateInfoUser(_user: user)
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
                if let profileImageUrl = user.profileImageUrl
                {
                    self.avatar.loadImageUsingCacheWithUrlString(profileImageUrl)
                }
            }
        }
    }
}


extension Profile: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            avatar.setRounded()
            avatar.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}
