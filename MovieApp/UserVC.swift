//
//  UserVC.swift
//  MovieApp-master
//
//  Created by Zwart on 6/20/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase

class UserVC: UITableViewController {
    @IBOutlet weak var lb_name: UILabel!
    
    
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var imageUser: UIImageView!
    var mDatabase: DatabaseReference!
    var user = UserInfo()
    @IBOutlet weak var viewTB: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageUser.setRounded()
        if(Auth.auth().currentUser != nil)
        {
            self.buttonLogin.isHidden = true
        }
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "03")!.draw(in: viewTB.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext();
        self.viewTB.backgroundColor = UIColor(patternImage: image!)
        self.tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            self.buttonLogin.isHidden = true
            
            TMDb.fetchUser(completionHandler: { (user, error) in
                if(error != nil) {
                    print(error!)
                } else {
                    self.user = user
                    self.lb_name.text = user.name
                }
            })
        
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
extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
