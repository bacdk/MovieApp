//
//  UserVC.swift
//  MovieApp-master
//
//  Created by Zwart on 6/20/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase

class UserController: UITableViewController {
    
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var viewTB: UIView!
    var mDatabase: DatabaseReference!
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUser.setRounded()
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "Unknown")!.draw(in: view.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext();
        self.tableView.backgroundColor = UIColor(patternImage: image!)
        self.tableView.tableFooterView = UIView(frame: .zero)
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        tableView.backgroundView = blurEffectView
    }
    
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(Auth.auth().currentUser != nil)
        {
            //Get user's information
            TMDb.fetchUser(completionHandler: { (user, error) in
                if(error != nil) {
                    self.alertOK(message: error!, title: "Error")
                    print(error!)
                    return
                } else {
                    self.lb_name.text = user.name
                    if let profileImageUrl = user.profileImageUrl
                    {
                        self.imageUser.loadImageUsingCacheWithUrlString(profileImageUrl)
                    }
                }
            })
            self.buttonLogin.isHidden = true
            // 1 session
            return 1
        }
        else
        {
            self.buttonLogin.isHidden = false
            lb_name.text = "Please login"
            // 0 session
            return 0
        }
    }
    
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    //
    @IBAction func Login(_ sender: Any) {
        let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "LoginStoryboard")
        self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
    }
    
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //User Profile
        if indexPath.row == 0
        {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! Profile
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        //Change passwword
        if indexPath.row == 1
        {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePassword") as! ChangePasswordViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        //Book ticket History
        if indexPath.row == 3
        {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "History") as! History
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        //Logout event
        if indexPath.row == 4
        {
            handleLogout()
        }
    }
    
    //Log out handle
    func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        viewDidLoad()
        tableView.reloadData()
    }
}

