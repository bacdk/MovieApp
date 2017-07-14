//
//  BuyTicket.swift
//  MovieApp-master
//
//  Created by miceli on 6/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
//import MBProgressHUD
import Firebase

class BuyTicketController: UIViewController {
    
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var txtFilmName: UILabel!
    @IBOutlet weak var txtActor: UILabel!
    @IBOutlet weak var lblNgay: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    @IBOutlet weak var viewAbove: UIView!
    @IBOutlet weak var lblnumberTicket: UILabel!
    @IBOutlet weak var txtPrice: UILabel!
    var mDatabase: DatabaseReference!
    
    var ngay: String!
    var time: String = ""
    var ticketNumber: Int64  = 0
    var priceFilm: Int64 = 55000
    var money: Int64 = 0
    var indexTime:Int!
    var indexNgay:Int!
    var userInfo: User!
    var movie: Movie!
    var ticket = Ticket()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mDatabase = Database.database().reference()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    //
    func loadData() {
        //Pass data to View
        imgPoster.loadImageUsingCacheWithUrlString("\(prefixImage)w185\(movie.poster_path!)")
        imgPoster.layer.cornerRadius = CGFloat.init(05)
        imgPoster.dropShadow()
        imgPoster.layer.masksToBounds = true
        txtFilmName.text = movie.title
        txtTime.text = time
        txtPrice.text = String(priceFilm)
        //Get current date
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        if(indexNgay == 0)
        {
            ngay = String(day)+"-"+String(month)+"-"+String(year)
            lblNgay.text = ngay
        }
        else
        {
            ngay = String(day+1)+"-"+String(month)+"-"+String(year)
            lblNgay.text = ngay
        }
        //set image for view
        UIGraphicsBeginImageContext(viewAbove.frame.size)
        UIImage(named: "03")!.draw(in: viewAbove.frame)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext();
        self.viewAbove.backgroundColor = UIColor(patternImage: image!)
    }
    
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Event click Minus button
    @IBAction func btnMinus(_ sender: Any) {
        if (ticketNumber > 0) {
            ticketNumber = ticketNumber - 1;
            lblnumberTicket.text = String(ticketNumber)
            money = priceFilm * ticketNumber
            lblMoney.text = String(money) + "VND"
        }
    }
    
    //Event click Add button
    @IBAction func btnAdd(_ sender: Any) {
        ticketNumber = ticketNumber + 1;
        lblnumberTicket.text = String(ticketNumber)
        money = priceFilm * ticketNumber
        lblMoney.text = String(money) + " VND"
    }
    
    //Next
    @IBAction func btnNext(_ sender: Any) {
        if (ticketNumber > 0) {
            if Auth.auth().currentUser != nil { //Check user exist
                //Transfer to CHOOSE SEAT  screen
                let srcSeat = self.storyboard?.instantiateViewController(withIdentifier: "ChonCho") as! SeatViewController
                //Add value for ticket
                ticket.day = ngay
                ticket.id = movie.id
                ticket.name = movie.title
                ticket.image = movie.poster_path
                ticket.sove = ticketNumber
                ticket.tongtien = money
                ticket.time = time
                ticket.sove = ticketNumber
                //Transfer value to source screen
                srcSeat.ticket = ticket
                srcSeat.movie = movie
                srcSeat.indexNgay = indexNgay
                srcSeat.indexTime = indexTime
                //Action
                navigationController?.pushViewController(srcSeat, animated: true)
            }
            else {
                //Require login to use function book ticket (alert output)
                let alert = UIAlertController(title: "Login require", message:   "Please login befor using this function!", preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
                    let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "LoginStoryboard") as! LoginController
                    self.present(viewControllerYouWantToPresent, animated: true, completion: nil)
                })
                //Add action OK
                alert.addAction(OKAction)
                self.present(alert, animated: true){}
            }
        }
        else {
            //Require user choose at least one ticket
            alertOK(message: "Please choose at least 1 ticket", title: "Alert")
        }
    }
    
    //Get current id user
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!
    }
}
