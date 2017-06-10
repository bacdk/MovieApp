//
//  ChonXuatChieuViewController.swift
//  MovieApp-master
//
//  Created by Cntt23 on 6/7/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class ChonXuatChieuViewController: UIViewController {
    
    @IBOutlet weak var buttonScrool: UIScrollView!
    //Outlet
    //Ngay
    @IBOutlet weak var homNay: UIButton!
    @IBOutlet weak var ngayMai: UIButton!
    //Gio
    @IBOutlet weak var gio9AM: UIButton!
    @IBOutlet weak var gio1110AM: UIButton!
    @IBOutlet weak var gio12PM: UIButton!
    @IBOutlet weak var gio150PM: UIButton!
    @IBOutlet weak var gio430PM: UIButton!
    @IBOutlet weak var gio6PM: UIButton!
    @IBOutlet weak var gio710PM: UIButton!
    @IBOutlet weak var gio945PM: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var ButtonList = ["Button 1", "Button 2", "Button 3"]
        let buttonWidth = 100
        let buttonSpace = 10
        for (index,ButtonText) in ButtonList.enumerated(){
            //calculate the x coordinate of each button
            let xCoord = CGFloat(index*buttonWidth + index*buttonSpace)
            let codedButton:UIButton = UIButton(frame: CGRect(x:xCoord, y: 400, width: 100, height: 50))
            codedButton.backgroundColor = UIColor.red
            codedButton.setTitle(ButtonText, for: UIControlState.normal)
            
            codedButton.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            codedButton.tag = index
            
            let button:UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
            button.backgroundColor = .black
            button.setTitle("Button", for: .normal)
            button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
            
            self.buttonScrool.addSubview(codedButton)
            //self.buttonScrool.addSubview(button)
            self.view.addSubview(codedButton)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonClicked(){
       
    }
    //Hom nay
    @IBAction func isHomNay(_ sender: Any) {
        
    }
    
    //Ngay mai
    @IBAction func isNgayMai(_ sender: Any) {
        
    }
    
    //Chon gio
    @IBAction func chonGio(_ sender: Any) {
        
    }
    
    //Chon cho
    @IBAction func chonCho(_ sender: Any) {
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
