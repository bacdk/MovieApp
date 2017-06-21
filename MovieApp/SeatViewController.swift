//
//  NowPlayingViewController.swift
//  MovieApp-master
//
//  Created by miceli on 6/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//
import UIKit

class SeatViewController: UIViewController, ZSeatSelectorDelegate {
    var ticket: Ticket!
    var seatUserString:String = seatMap
    var seatMovieString:String = ""
    var movie: Movie!
    var indexNgay:Int!
    var indexTime:Int!
    
    var seatUser : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //var map2:String = ""
        //self.view.addSubview(seats)
        //print(indexNgay)
        if(indexNgay == 0)
        {
            TMDb.getSeatMap(id: movie.id, ngay: "Today", gio: ticket.time, completionHandler: { (seat, error) in
                if(error != nil) {
                    print(error!)
                } else {
                    self.seatMovieString = seat!
                    self.draw()
                }
            })
            print(self.seatMovieString)
//            map2 = (movie.today?[indexTime].seat!)!
        }
        else
        {
            TMDb.getSeatMap(id: movie.id, ngay: "Tomorrow", gio: ticket.time, completionHandler: { (seat, error) in
                if(error != nil) {
                    print(error!)
                } else {
                    self.seatMovieString = seat!
                    self.draw()
                }
            })
//            map2 = (movie.tomorrow?[indexTime].seat)!
        }

        //seatMovieString = map2

    }
    
    func draw(){
        let seats2 = ZSeatSelector()
        seats2.frame = CGRect(x: 0, y: 250, width: self.view.frame.size.width, height: 600)
        seats2.setSeatSize(CGSize(width: 30, height: 30))
        seats2.setAvailableImage(   UIImage(named: "A")!,
                                    andUnavailableImage:    UIImage(named: "U")!,
                                    andDisabledImage:       UIImage(named: "D")!,
                                    andSelectedImage:       UIImage(named: "S")!)
        seats2.layout_type = "Normal"
        seats2.setMap(seatMovieString)
        seats2.seat_price           = 5.0
        seats2.selected_seat_limit  = Int(ticket.sove!)
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
        let range: Range<String.Index> = seatMovieString.range(of: "/")!
        let numberofSeat:Int = seatMovieString.distance(from: seatMovieString.startIndex, to: range.lowerBound)
        //print(numberofSeat)
        for i in 0..<seatUser.count {
            let seat:ZSeat  = seatUser.object(at: i) as! ZSeat
            print("Seat at row: \(seat.row) and column: \(seat.column)\n")
            let pos = (seat.row-1)*(numberofSeat+1)+seat.column-1
            let index = seatMovieString.index(seatMovieString.startIndex, offsetBy: pos)
            seatMovieString.replaceSubrange(index...index, with: "U")
        }
        //print(numberofSeat)
        for i in 0..<seatUser.count {
            let seat:ZSeat  = seatUser.object(at: i) as! ZSeat
            print("Seat at row: \(seat.row) and column: \(seat.column)\n")
            let pos = (seat.row-1)*(numberofSeat+1)+seat.column-1
            let index = seatUserString.index(seatUserString.startIndex, offsetBy: pos)
            seatUserString.replaceSubrange(index...index, with: "U")
        }
        //print(seats)
        //print(seatMovieString)
        ticket.soghe = [Int]()
        for seat in seatUser
        {
            ticket.soghe.append((seat as! ZSeat).stt)
        }
        //print(ticket.)
        ticket.seat=seatUserString;
        TMDb.bookTicket(ticket: ticket)
        if(indexNgay==0)
        {
            TMDb.updateSeat(id: movie.id, ngay: "Today", gio: ticket.time, seat: seatMovieString)
        }
        else{
            TMDb.updateSeat(id: movie.id, ngay: "Tomorrow", gio: ticket.time, seat: seatMovieString)
        }
        let detailTicket = self.storyboard?.instantiateViewController(withIdentifier: "detailTicket") as! DetailTicketVC
        detailTicket.screen = "bookTicket"
        detailTicket.ticket = ticket
        self.present(detailTicket, animated: true, completion: nil)
    }
    
}
