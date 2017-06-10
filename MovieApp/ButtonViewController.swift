//
//  NowPlayingViewController.swift
//  MovieApp-master
//
//  Created by miceli on 6/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//
import UIKit

class ButtonViewController: UIViewController, ZSeatSelectorDelegate {
    var noi:String = ""
    var seatUser : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let map:String =    "AAAAA_DAAAA/" +
            "UAAAA_DAAAA/" +
            "UUUUU_DAAAA/" +
            "UAAAA_AAAAA/" +
        "AAAAA_AAAAA/";
        
        let seats = ZSeatSelector()
        seats.frame = CGRect(x: 0, y: 50, width: self.view.frame.size.width, height: 150)
        seats.setSeatSize(CGSize(width: 10, height: 10))
        seats.setAvailableImage(UIImage(named: "A")!,
                                andUnavailableImage:UIImage(named: "U")!,
                                andDisabledImage:   UIImage(named: "D")!,
                                andSelectedImage:   UIImage(named: "S")!)
        seats.layout_type = "Normal"
        seats.setMap(map)
        seats.seat_price = 10.0
        seats.selected_seat_limit = 3
        seats.seatSelectorDelegate = self
        //self.view.addSubview(seats)
        
        let map2:String =   "_DDDDDD_DDDDDD_DDDDDDDD_/" +
            "_AAAAAA_AAAAAA_DUUUAAAA_/" +
            "________________________/" +
            "_AAAAAUUAAAUAAAAUAAAAAAA/" +
            "_UAAUUUUUUUUUUUUUUUAAAAA/" +
            "_AAAAAAAAAAAUUUUUUUAAAAA/" +
            "_AAAAAAAAUAAAAUUUUAAAAAA/" +
        "_AAAAAUUUAUAUAUAUUUAAAAA/"
        noi = map2
        let seats2 = ZSeatSelector()
        seats2.frame = CGRect(x: 0, y: 250, width: self.view.frame.size.width, height: 600)
        seats2.setSeatSize(CGSize(width: 30, height: 30))
        seats2.setAvailableImage(   UIImage(named: "A")!,
                                    andUnavailableImage:    UIImage(named: "U")!,
                                    andDisabledImage:       UIImage(named: "D")!,
                                    andSelectedImage:       UIImage(named: "S")!)
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
        var total:Float = 0.0;
        for i in 0..<seats.count {
            let seat:ZSeat  = seats.object(at: i) as! ZSeat
            print("Seat at row: \(seat.row) and column: \(seat.column)\n")
            total += seat.price
        }
        seatUser = seats
        //print(seats)
        //print(noi)
        print("----- Total -----\n")
        print("----- \(total) -----\n")
    }
    
    @IBAction func chooseSeat(_ sender: UIButton) {
        handleBookSeat()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleBookSeat() {
        let range: Range<String.Index> = noi.range(of: "/")!
        let numberofSeat:Int = noi.distance(from: noi.startIndex, to: range.lowerBound)
        //print(numberofSeat)
        for i in 0..<seatUser.count {
            let seat:ZSeat  = seatUser.object(at: i) as! ZSeat
            print("Seat at row: \(seat.row) and column: \(seat.column)\n")
            let pos = (seat.row-1)*(numberofSeat+1)+seat.column-1
            let index = noi.index(noi.startIndex, offsetBy: pos)
            noi.replaceSubrange(index...index, with: "U")
        }
        //print(seats)
        print(noi)
    }
    
}
