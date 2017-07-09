//
//  ImagePicker.swift
//  MovieApp-master
//
//  Created by Zwart on 6/24/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import Foundation
import Firebase

//avatar with tag 300
extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func handleSelectProfileImageView() {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            let imageView = self.view.viewWithTag(300) as? UIImageView
            imageView?.setRounded()
            imageView?.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled picker")
        dismiss(animated: true, completion: nil)
    }
    
}
