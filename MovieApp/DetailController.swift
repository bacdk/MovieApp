//
//  DetailController.swift
//  MovieApp-master
//
//  Created by Tai Nhat Huynh on 6/10/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class DetailController: UITableViewController,UIWebViewDelegate  {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var viewInTable: UIView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var genris: UILabel!
    @IBOutlet weak var posterImage: DesignImage!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var video: UIWebView!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var overview: UITextView!
    
    var movie: Movie!
    var hourToday = [Schedule]()
    var hourTomorrow = [Schedule]()
    var Ngay=["Today", "Tomorrow"]
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadData();
    }
    func check()->Bool
    {
        if movie.today == nil
        {
            // return
        }
        return false
    }
    
    func loadData()
    {
        hourToday = movie.today!
        hourTomorrow = movie.tomorrow!
        overview?.text = movie.overview
        nameMovie?.text = movie.title
        rate?.text = "★ \(movie.vote_average!)"
        let request = URLRequest(url: URL(string: "\(prefixYoutube)\(movie.trailer!)")!)
        video.loadRequest(request)
        video.delegate = self
        time?.text = "\(movie.runtime!) min"
        //genris?.text = movie.genres?.rawValue
        let img = Downloader.downloadImageWithURL("\(prefixImage)w185\(self.movie.poster_path!)")
        posterImage.image = img
        let image = Downloader.downloadImageWithURL("\(prefixImage)w780\(self.movie.poster_path!)")
        UIGraphicsGetCurrentContext();
        self.view.backgroundColor = UIColor(patternImage: image!)
        UIGraphicsBeginImageContext(view.frame.size)
        UIImage(named: "03")!.draw(in: view.frame)
        let image1 = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext();
        self.viewInTable.backgroundColor = UIColor(patternImage: image1!)
        self.tableView.separatorStyle = .none
        posterImage.layer.shadowOpacity = 0.4
        posterImage.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        
        //Set blur effect for table
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        tableView.backgroundView = blurEffectView
    }
    func webViewDidFinishLoad(_ video: UIWebView) // here hide it
    {
        spinner.stopAnimating()
        //spinner.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Dispose of any resources that can be recreated.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override  func numberOfSections(in tableView: UITableView) -> Int
    {
        if(hourToday.count == 0 && hourTomorrow.count==0)
        {
            return 0
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 11)
        header.textLabel?.textColor = UIColor.lightText
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let day = Ngay[section]
        return day
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "XuatChieu", for: indexPath) as UITableViewCell
        let f = indexPath.section
        if (f == 0)
        {
            let buttonWidth = 60
            let buttonSpace = 5
            for (index,_) in hourToday.enumerated(){
                
                let xCoord = CGFloat(index*buttonWidth + index*buttonSpace)
                
                let codedButton = codeButton(frame: CGRect(x:xCoord, y: 5, width: 50, height: 20))
                codedButton.indexNgay=0
                codedButton.setTitle(hourToday[index].hour, for: UIControlState.normal)
                codedButton.tag = index
                codedButton.addTarget(self, action:#selector(self.buttonPressed), for: .touchUpInside)
                codedButton.setFormat()
                cell.contentView.addSubview(codedButton)
            }
        }
        else
        {
            let buttonWidth = 60
            let buttonSpace = 5
            for (index,_) in hourTomorrow.enumerated(){
                
                let xCoord = CGFloat(index*buttonWidth + index*buttonSpace)
                
                let codedButton = codeButton(frame: CGRect(x:xCoord, y: 5, width: 50, height: 20))
                
                codedButton.indexNgay = 1
                codedButton.setTitle(hourTomorrow[index].hour, for: UIControlState.normal)
                codedButton.tag = index
                codedButton.addTarget(self, action:#selector(self.buttonPressed), for: .touchUpInside)
                codedButton.setFormat()
                
                cell.contentView.addSubview(codedButton)
            }
            
        }
        return cell
    }
    
    //Button Action is
    func buttonPressed(sender:codeButton!)
    {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicket") as! BuyTicket
        srcBuyTicket.movie = movie
        srcBuyTicket.time = (sender.titleLabel?.text)!
        srcBuyTicket.indexNgay = sender.indexNgay
        srcBuyTicket.indexTime = sender.tag
        navigationController?.pushViewController(srcBuyTicket, animated: true)
        let buttonRow = sender.tag
        print("button is Pressed")
        print("Clicked Button Row is",buttonRow)
    }
    
}
extension UIButton {
    
    func setFormat() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = CGFloat.init(10)
        //self.layer.borderColor = UIColor.white as! CGColor
        self.backgroundColor = UIColor.clear
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
}


class codeButton: UIButton {
    var indexNgay:            Int     = 0
}
