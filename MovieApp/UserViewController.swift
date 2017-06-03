//
//  UserViewController.swift
//  MovieApp-master
//
//  Created by miceli on 6/4/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase
class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        }
    }
    
    @IBAction func Logout(_ sender: UIButton) {
        handleLogout()
    }
    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    }


}
