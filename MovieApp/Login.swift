//
//  Login.swift
//  MovieApp-master
//
//  Created by Zwart on 6/18/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase
class Login: UIViewController {

    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var btnback: UIButton!
    @IBOutlet weak var lbl_user: UITextField!
    @IBOutlet weak var txt_pass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "Unknown")!.draw(in: view.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext();
        self.view.backgroundColor = UIColor(patternImage: image!)
        

    }
    func backAction(){
        //print("Back Button Clicked")
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func Login(_ sender: UIButton) {
        handleLogin()
    }
    
    func handleLogin() {
        guard let email = lbl_user.text, let password = txt_pass.text else {
            self.labelStatus.text = "Form is not valid"
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if let error = error {
                print(error)
                self.labelStatus.text = error.localizedDescription
                return
            }
            
            //successfully logged in our user
            self.dismiss(animated: true, completion: nil)
            
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
