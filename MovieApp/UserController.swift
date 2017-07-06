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
    var mDatabase: DatabaseReference!
    @IBOutlet weak var viewTB: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUser.setRounded()
        //        imageUser.layer.borderWidth = 1
        //        imageUser.layer.borderColor = UIColor.white.cgColor
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(Auth.auth().currentUser != nil)
        {
            //self.buttonLogin.isHidden = true
            TMDb.fetchUser(completionHandler: { (user, error) in
                if(error != nil) {
                    print(error!)
                } else {
                    self.lb_name.text = user.name
                    if let profileImageUrl = user.profileImageUrl
                    {
                        self.imageUser.loadImageUsingCacheWithUrlString(profileImageUrl)
                    }
                }
            })
            self.buttonLogin.isHidden = true
            return 1
        }
        else
        {
            self.buttonLogin.isHidden = false
            lb_name.text = "Vui lòng đăng nhập"
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    @IBAction func Login(_ sender: Any) {
        
        let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "LoginStoryboard")
        self.present(viewControllerYouWantToPresent!, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! Profile
            //nextViewController.userName.text = user.name
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        if indexPath.row == 1
        {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ChangePassword") as! ChangePasswordViewController
            //nextViewController.userName.text = user.name
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        if indexPath.row == 4
        {
            handleLogout()
        }
        if indexPath.row == 3
        {
            let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "History") as! History
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        print("You selected cell number: \(indexPath.row)!")
        //        NSLog("You selected cell number: \(indexPath.row)!")
        //        self.performSegue(withIdentifier: "yourIdentifier", sender: self)
    }
    
    
    func selectView(withRowAt row: Int) -> String {
        switch row {
            //        case 0:
            //            return mainMenu
            //        case 1:
            //            return poinView
            //        case 2:
            //            return friendView
            //        case 3:
            //            return alarmView
            //        case 4:
        //            return historyView
        default:
            return "đ"
        }
    }
    func handleLogout() {
        
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        viewDidLoad()
        tableView.reloadData()
        //        let loginController = UserVC()
        //        present(loginController, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        //        let loginController = LoginController()
        //        present(loginController, animated: true, completion: nil)
        
    }
}

