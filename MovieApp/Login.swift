//
//  Login.swift
//  MovieApp-master
//
//  Created by Zwart on 6/18/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class Login: UIViewController {

    @IBOutlet weak var lbl_user: UITextField!
    @IBOutlet weak var txt_pass: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "BlueClouds")!.draw(in: view.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext();
        self.view.backgroundColor = UIColor(patternImage: image!)
        lbl_user.backgroundColor = UIColor.clear
        txt_pass.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
