//
//  XXXXXXViewController.swift
//  MovieApp-master
//
//  Created by Cntt23 on 6/10/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class XXXXXXViewController: UIViewController {
    class ZSeat: UIButton {
        var row:            Int     = 0
        var column:         Int     = 0
        var available:      Bool    = true;
        var disabled:       Bool    = true;
        var selected_seat:  Bool    = true;
        var price:          Float   = 0.0
        var label:          String  = ""
    }
    var gio : [String] = ["9h20","2h30","2h52","ChoBac","ChoKhoa"]
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in gio
        {
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func load()
    {
        for i in gio
        {
            
        }
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


