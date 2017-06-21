//
//  DetailTicketVC.swift
//  MovieApp-master
//
//  Created by Zwart on 6/21/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class DetailTicketVC: UIViewController, ZSeatSelectorDelegate {
    
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
        
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "03")!.draw(in: view.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext();
        self.view.backgroundColor = UIColor(patternImage: image!)
        
        if screen == "History"
        {
            btnBack.isHidden = true
        }
        lblName.text = ticket.name
        lblNgay.text = "Ngày: \(ticket.day!)"
        lblTime.text = "Time: \(ticket.time!)"
        lblSove.text = "Số vé: \(ticket.sove!)"
        lblTongtien.text = "Tổng tiền: \(ticket.tongtien!)"
        var arraySeat = ""
        for seat in ticket.soghe{
            arraySeat = arraySeat + String(seat) + " "
        }
        
        lblSoghe.text = arraySeat
        let img1 = Downloader.downloadImageWithURL("\(prefixImage)w185\(ticket.image!)")
        imagePoster.image = img1
        imagePoster.layer.cornerRadius = CGFloat.init(05)
        imagePoster.layer.masksToBounds = true
        let map2:String =   ticket.seat
        let seats2 = ZSeatSelector()
        seats2.frame = CGRect(x: 0, y: 250, width: self.view.frame.size.width, height: 600)
        seats2.setSeatSize(CGSize(width: 30, height: 30))
        seats2.setAvailableImage(   UIImage(named: "sT")!,
                                    andUnavailableImage:    UIImage(named: "sE")!,
                                    andDisabledImage:       UIImage(named: "sT")!,
                                    andSelectedImage:       UIImage(named: "sT")!)
        seats2.layout_type = "Normal"
        seats2.setMap(map2)
        seats2.seat_price           = 5.0
        seats2.selected_seat_limit  = 5
        seats2.seatSelectorDelegate = self
        seats2.maximumZoomScale         = 5.0
        seats2.minimumZoomScale         = 0.05
        self.view.addSubview(seats2)
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
}
