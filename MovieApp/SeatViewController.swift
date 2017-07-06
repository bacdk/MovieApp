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
    
<<<<<<< HEAD
    var seatUser : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //var map2:String = ""
        //self.view.addSubview(seats)
        //print(indexNgay)
        if(indexNgay == 0)
        {
=======
    @IBOutlet weak var bookButton: DesignButton!
    @IBOutlet weak var imageSeat: UIImageView!
    var seatUser : NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    func loadData()
    {
        if(indexNgay == 0)
        {
            // get seat map by date
>>>>>>> origin/fbb
            TMDb.getSeatMap(id: movie.id, ngay: "Today", gio: ticket.time, completionHandler: { (seat, error) in
                if(error != nil) {
                    print(error!)
                } else {
                    self.seatMovieString = seat!
                    self.draw()
                }
            })
<<<<<<< HEAD
            print(self.seatMovieString)
//            map2 = (movie.today?[indexTime].seat!)!
        }
        else
        {
=======
        }
        else
        {
            // get seat map by date
>>>>>>> origin/fbb
            TMDb.getSeatMap(id: movie.id, ngay: "Tomorrow", gio: ticket.time, completionHandler: { (seat, error) in
                if(error != nil) {
                    print(error!)
                } else {
                    self.seatMovieString = seat!
                    self.draw()
                }
            })
<<<<<<< HEAD
//            map2 = (movie.tomorrow?[indexTime].seat)!
        }

        //seatMovieString = map2

    }
    
=======
        }
    }
>>>>>>> origin/fbb
    func draw(){
        let seats2 = ZSeatSelector()
        var _y : Int
        if UIDevice.current.orientation.isLandscape {
            _y = Int(bookButton.frame.maxY) + 5
        }
        else
        {
            _y = 250
        }
        seats2.frame = CGRect(x: 0, y: _y, width: Int(self.view.frame.size.width), height: 600)
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
        seats2.tag = 100
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
<<<<<<< HEAD
        //print(seats)
        //print(noi)
=======
>>>>>>> origin/fbb
        print("----- Total -----\n")
        print("----- \(total) -----\n")
    }
    
    @IBAction func chooseSeat(_ sender: UIButton) {
<<<<<<< HEAD
        handleBookSeat()
=======
        if (Int(ticket.sove) == seatUser.count)
        {
            let alert = UIAlertController(title: "Book ticket", message:   "View infomation of ticket?", preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
                self.handleBookSeat()
            })
            // Create Cancel button
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
                //print("Cancel button tapped");
            }
            alert.addAction(cancelAction)
            alert.addAction(OKAction)
            
            self.present(alert, animated: true){}
        }
        else{
            alertOK(message: "Please choose enough \(ticket.sove!) seat", title: "Message")
        }
>>>>>>> origin/fbb
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func handleBookSeat() {
        let range: Range<String.Index> = seatMovieString.range(of: "/")!
        let numberofSeat:Int = seatMovieString.distance(from: seatMovieString.startIndex, to: range.lowerBound)
        //print(numberofSeat)
<<<<<<< HEAD
=======
        //change character in seat array and upload into Movie data
>>>>>>> origin/fbb
        for i in 0..<seatUser.count {
            let seat:ZSeat  = seatUser.object(at: i) as! ZSeat
            print("Seat at row: \(seat.row) and column: \(seat.column)\n")
            let pos = (seat.row-1)*(numberofSeat+1)+seat.column-1
            let index = seatMovieString.index(seatMovieString.startIndex, offsetBy: pos)
            seatMovieString.replaceSubrange(index...index, with: "U")
        }
<<<<<<< HEAD
        //print(numberofSeat)
=======
        //change character in seat array and upload into user's ticket  data
>>>>>>> origin/fbb
        for i in 0..<seatUser.count {
            let seat:ZSeat  = seatUser.object(at: i) as! ZSeat
            print("Seat at row: \(seat.row) and column: \(seat.column)\n")
            let pos = (seat.row-1)*(numberofSeat+1)+seat.column-1
            let index = seatUserString.index(seatUserString.startIndex, offsetBy: pos)
            seatUserString.replaceSubrange(index...index, with: "U")
        }
<<<<<<< HEAD
        //print(seats)
        //print(seatMovieString)
=======
        //get seat numbers
>>>>>>> origin/fbb
        ticket.soghe = [Int]()
        for seat in seatUser
        {
            ticket.soghe.append((seat as! ZSeat).stt)
        }
<<<<<<< HEAD
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
    
=======
        ticket.seat=seatUserString;
        //pass data to DetailTicket screen
        let detailTicket = self.storyboard?.instantiateViewController(withIdentifier: "detailTicket") as! DetailTicketVC
        detailTicket.screen = "bookTicket"
        detailTicket.ticket = ticket
        detailTicket.indexNgay = indexNgay
        detailTicket.seatMovieString = seatMovieString
        self.present(detailTicket, animated: true, completion: nil)
    }
    //Check orientation is
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {        //at lanscape
            self.view.viewWithTag(100)?.removeFromSuperview()
            loadData()
        } else {
            self.view.viewWithTag(100)?.removeFromSuperview()
            loadData()
        }
    }
>>>>>>> origin/fbb
}
