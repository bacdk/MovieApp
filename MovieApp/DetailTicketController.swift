//
//  DetailTicketVC.swift
//  MovieApp-master
//
//  Created by Zwart on 6/21/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class DetailTicketVC: UIViewController, ZSeatSelectorDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var lblSoghe: UILabel!
    @IBOutlet weak var lblTongtien: UILabel!
    @IBOutlet weak var lblSove: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblNgay: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    var indexNgay:Int!
    var screen : String = ""
    var seatUser : NSMutableArray = []
    var ticket: Ticket!
    var seatMovieString:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        draw()
    }
    
    func draw()
    {
        UIGraphicsBeginImageContext(scrollView.frame.size)
        UIImage(named: "03")!.draw(in: scrollView.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext();
        self.scrollView.backgroundColor = UIColor(patternImage: image!)
        
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
        imagePoster.loadImageUsingCacheWithUrlString("\(prefixImage)w185\(ticket.image!)")
        imagePoster.layer.cornerRadius = CGFloat.init(05)
        imagePoster.layer.masksToBounds = true
        let _y = imagePoster.frame.maxY + 20
        let map2:String =  ticket.seat
        let seats2 = ZSeatSelector()
        seats2.tag = 100
        seats2.frame = CGRect(x: 0, y: _y, width: self.scrollView.frame.size.width, height: 600)
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
        self.scrollView.addSubview(seats2)
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
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func payButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "Comfirm payment!", message:   "By clicking OK, you agree to our MovieApp policy and pay for your Ticket", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
            do
            {
                try self.upload()
            }
            catch
            {
                let alertView = UIAlertController(title: "Alert", message: "Error!. Try later", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertView.addAction(action)
                self.present(alertView, animated: true, completion: nil)
            }
        })
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            //print("Cancel button tapped");
        }
        alert.addAction(cancelAction)
        alert.addAction(OKAction)
        
        self.present(alert, animated: true){}
    }
    func upload()
    {
        TMDb.bookTicket(ticket: self.ticket, completionHandler: {(error) in
            if(error != nil) {
                self.alertOK(message: error! as! String, title: "Error")
                print(error!)
                return
            }
        })
        if(self.indexNgay==0)
        {
            TMDb.updateSeat(id: self.ticket.id, ngay: "Today", gio: self.ticket.time, seat: self.seatMovieString, completionHandler: {(error) in
                if(error != nil) {
                    self.alertOK(message: error! as! String, title: "Error")
                    print(error!)
                    return
                }
            })
        }
        else{
            TMDb.updateSeat(id: self.ticket.id, ngay: "Tomorrow", gio: self.ticket.time, seat: self.seatMovieString, completionHandler: {(error) in
                if(error != nil) {
                    self.alertOK(message: error! as! String, title: "Error")
                    print(error!)
                    return
                }
            })
        }
        self.success()
    }
    func success() {
        let alert  = UIAlertController(title: "Successful!", message:   "Pay success", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
            let detailTicket = self.storyboard?.instantiateViewController(withIdentifier: "ticketStoryboard") as! TicketVC
            detailTicket.screen = "Book"
            detailTicket.ticket = self.ticket
            self.present(detailTicket, animated: true, completion: nil)
        })
        alert.addAction(OKAction)
        
        self.present(alert, animated: true){}
    }
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        if UIDevice.current.orientation.isLandscape {
            print("Láncape")
            self.scrollView.viewWithTag(100)?.removeFromSuperview()
            draw()
        } else {
            print("cutcape")
            self.scrollView.viewWithTag(100)?.removeFromSuperview()
            draw()
        }
    }
}
