//
//  TicketVC.swift
//  MovieApp-master
//
//  Created by Zwart on 7/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class TicketVC: UIViewController {

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var lblSoghe: UILabel!
    @IBOutlet weak var lblTongtien: UILabel!
    @IBOutlet weak var lblSove: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblNgay: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    var screen : String = ""
    var seatUser : NSMutableArray = []
    var ticket: Ticket!
    override func viewDidLoad() {
        super.viewDidLoad()
        if (screen != "Book")
        {
            btnBack.isHidden = true
        }
        draw()
    }
    
    func draw()
    {
        lblName.text = ticket.name.uppercased()
        lblNgay.text = ticket.day!
        lblTime.text = ticket.time!
        lblSove.text = String(ticket.sove!)
        lblTongtien.text = String(ticket.tongtien!)
        var arraySeat = ""
        for seat in ticket.soghe{
            arraySeat = arraySeat + String(seat) + " "
        }
        lblSoghe.text = arraySeat
        let img1 = Downloader.downloadImageWithURL("\(prefixImage)w780\(ticket.image!)")
        imagePoster.image = img1
        UIGraphicsBeginImageContext(view.frame.size)
        UIGraphicsGetCurrentContext();
        self.view.backgroundColor = UIColor(patternImage: img1!)
    }
    
    func seatSelected(_ seat: ZSeat) {
        //print("Seat at row: \(seat.row) and column: \(seat.column)\n")
    }
    
    func getSelectedSeats(_ seats: NSMutableArray) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        //        self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
       
    }


}
