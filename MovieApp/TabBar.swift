//
//  TabBar.swift
//  MovieApp-master
//
//  Created by Zwart on 6/20/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class TabBar: UITabBarController, UITabBarControllerDelegate {
    @IBAction func unwindToLoginScreen(segue:UIStoryboardSegue) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = self
        self.delegate = self
<<<<<<< HEAD
        // Do any additional setup after loading the view.
=======
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear        // Do any additional setup after loading the view.
>>>>>>> origin/fbb
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.items?.index(of: item) == 0 {
            tabName="NowPlaying"
<<<<<<< HEAD
            print(tabName)
        }
        if tabBar.items?.index(of: item) == 1 {
            tabName="Popular"
            print(tabName)
        }
        if tabBar.items?.index(of: item) == 2 {
            tabName="UpComing"
            print(tabName)
=======
            //print(tabName)
        }
        if tabBar.items?.index(of: item) == 1 {
            tabName="Popular"
            //print(tabName)
        }
        if tabBar.items?.index(of: item) == 2 {
            tabName="UpComing"
            //print(tabName)
>>>>>>> origin/fbb
        }
    }
    
    // UITabBarControllerDelegate
<<<<<<< HEAD
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
=======
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
>>>>>>> origin/fbb
        print("Selected view controller")
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
