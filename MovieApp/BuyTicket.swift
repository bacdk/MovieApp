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

class BuyTicket: UIViewController {
    
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var txtFilmName: UILabel!
    @IBOutlet weak var txtActor: UILabel!
    
    @IBOutlet weak var lblNgay: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var txtTime: UILabel!
    
    @IBOutlet weak var lblnumberTicket: UILabel!
    
    @IBOutlet weak var txtPrice: UILabel!
    var mDatabase: DatabaseReference!
    // var progressDialog: MBProgressHUD!
    
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

    func loadData() {
        let img1 = Downloader.downloadImageWithURL("\(prefixImage)w185\(movie.poster_path!)")
        imgPoster.image = img1
        imgPoster.layer.cornerRadius = CGFloat.init(05)
        txtFilmName.text = movie.title
        txtTime.text = time
        txtPrice.text = String(priceFilm)
        //get ngay
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        //print(ngay)
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
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnMinus(_ sender: Any) {
        if (ticketNumber > 0) {
            ticketNumber = ticketNumber - 1;
            lblnumberTicket.text = String(ticketNumber)
            money = priceFilm * ticketNumber
            lblMoney.text = String(money) + "VND"
        }
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        ticketNumber = ticketNumber + 1;
        lblnumberTicket.text = String(ticketNumber)
        money = priceFilm * ticketNumber
        lblMoney.text = String(money) + " VND"
    }
    
    @IBAction func btnNext(_ sender: Any) {
        if (ticketNumber > 0) {
            if Auth.auth().currentUser != nil {
                let srcSeat = self.storyboard?.instantiateViewController(withIdentifier: "ChonCho") as! SeatViewController
                ticket.day = ngay
                ticket.id = movie.id
                ticket.name = movie.title
                ticket.image = movie.poster_path
                ticket.sove = ticketNumber
                ticket.tongtien = money
                ticket.time = time
                ticket.sove = ticketNumber
                srcSeat.ticket = ticket
                srcSeat.movie = movie
                srcSeat.indexNgay = indexNgay
                srcSeat.indexTime = indexTime
                navigationController?.pushViewController(srcSeat, animated: true)
            }
            else {
                //showAlertDialog(message: "Hãy đăng nhập trước khi sử dụng tính năng này")
                let alert = UIAlertController(title: "Login require", message:   "Hãy đăng nhập trước khi sử dụng tính năng này", preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ -> Void in
                    //                    let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LoginStoryboard") as! LoginController
                    //                    self.navigationController?.pushViewController(nextViewController, animated: true)
                    let viewControllerYouWantToPresent = self.storyboard?.instantiateViewController(withIdentifier: "LoginStoryboard") as! LoginController
                    self.present(viewControllerYouWantToPresent, animated: true, completion: nil)
                })
                
                alert.addAction(OKAction)
                self.present(alert, animated: true){}
            }
        }
        else {
            showAlertDialog(message: "Hãy chọn ít nhất 1 vé")
        }
    }
    
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!
    }
    
}


//let alert = UIAlertController(title: "Success", message: "Logged In", preferredStyle: .Alert)
//let action = UIAlertAction(title: "OK", style: .Default) { (action) -> Void in
//    let viewControllerYouWantToPresent = self.storyboard?.instantiateViewControllerWithIdentifier("SomeViewControllerIdentifier")
//    self.presentViewController(viewControllerYouWantToPresent!, animated: true, completion: nil)
//}
//alert.addAction(action)
//self.presentViewController(alert, animated: true, completion: nil)
