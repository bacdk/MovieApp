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
    
    //var filmInfo: FilmInfo!
    var time: String = ""
    var ticketNumber: Int64  = 0
    var priceFilm: Int64 = 55000
    var money: Int64 = 0
    
    var userInfo: User!
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mDatabase = Database.database().reference()
        // Do any additional setup after loading the view.
        loadData()
        //print(movie.poster_path)
        loadDataFromDB()
    }
    
    func loadDataFromDB() {
        //show progress
        showProgress()
//        mDatabase.child("films").child(filmInfo.filmType).child(filmInfo.filmId).child("showTimes").child(time).child("showTimeInfo").observeSingleEvent(of: .value, with: { (snapshot) in
//            self.hideProgress()
//            if let showTimeInfo = snapshot.value as? [String: AnyObject] {
//                let price = showTimeInfo["price"] as? Int64 ?? 0
//                let type = showTimeInfo["type"] as? String ?? ""
//                let timeShow = showTimeInfo["time"] as? String ?? ""
//                //load data
//                self.txtPrice.text = String(price) + "VND"
//                self.txtTime.text = type + " - " + timeShow
//                self.priceFilm = price
//                
//            }
//        })
    }
    
    func showProgress() {
//        progressDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
//        progressDialog.mode = MBProgressHUDMode.indeterminate
//        progressDialog.label.text = "Đang tải..."
    }
    
    func hideProgress() {
       // progressDialog.hide(animated: true)
    }
    
    func loadData() {
        let img1 = Downloader.downloadImageWithURL("\(prefixImage)w185\(movie.poster_path!)")
        imgPoster.image = img1
        txtFilmName.text = movie.title
        txtTime.text = time
        txtPrice.text = String(priceFilm)
        //txtActor.text =
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
                if (userInfo != nil) {
//                    if (Int64(userInfo.balance) < money) {
//                        showAlertDialog(message: "Số tiền trong tài khoản của bạn không đủ")
//                    }
//                    else {
//                        let src = self.storyboard?.instantiateViewController(withIdentifier: "choosePlacesId") as! ChoosePlacesViewController
//                        src.filmInfo = filmInfo
//                        src.time = "850"
//                        navigationController?.pushViewController(src, animated: true)
//                    }
                    
                }
                else {
                    mDatabase.child("users").child(getUid()).observeSingleEvent(of: .value, with: { (snapshot) in
                        if let user = snapshot.value as? [String: AnyObject] {
                            let fullName = user["fullName"] as? String ?? ""
                            let email = user["email"] as? String ?? ""
                            let address = user["address"] as? String ?? ""
                            let phone = user["phone"] as? String ?? ""
                            let balance = user["balance"] as? Double ?? 0
                            let password = user["password"] as? String ?? ""
                            
//                            self.userInfo = User.init(fullName: fullName, email: email, address: address, balance: balance, password: password, phone: phone, uid: self.getUid())
//                            
//                            if (Int64(self.userInfo.balance) < self.money) {
//                                self.showAlertDialog(message: "Số tiền trong tài khoản của bạn không đủ")
//                            }
//                            else {
//                                let src = self.storyboard?.instantiateViewController(withIdentifier: "choosePlacesId") as! ChoosePlacesViewController
//                                src.filmInfo = self.filmInfo
//                                src.time = "850"
//                                self.navigationController?.pushViewController(src, animated: true)
//                            }
                            
                        }
                    })
                }
            }
            else {
                showAlertDialog(message: "Hãy đăng nhập trước khi sử dụng tính năng này")
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
