//
//  DetailController.swift
//  MovieApp-master
//
//  Created by Tai Nhat Huynh on 6/10/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

<<<<<<< HEAD
class DetailController: UITableViewController {
    
    @IBOutlet weak var video: UIWebView!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var overview: UITextView!
    var movieId: Int!
    var movie: Movie!
    var listVideos = [Trailer]()
    
    
=======
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
>>>>>>> origin/fbb
    var hourToday = [Schedule]()
    var hourTomorrow = [Schedule]()
    var Ngay=["Today", "Tomorrow"]
    
<<<<<<< HEAD
    override func viewDidLoad() {
        
        super.viewDidLoad()
        overview?.text = movie.overview
        nameMovie?.text = movie.title
        hourToday = movie.today!
        hourTomorrow = movie.tomorrow!
        
        if listVideos.count != 0
        {
            let vide = listVideos[0]
            let request = URLRequest(url: URL(string: "\(prefixYoutube)\(vide.key!)")!)
            video.loadRequest(request)
        }
        loadData();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    func loadData()
    {
        
=======
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadData();
    }
    
    func loadData()
    {
        hourToday = movie.today
        hourTomorrow = movie.tomorrow
        overview?.text = movie.overview
        nameMovie?.text = movie.title
        rate?.text = "★ \(movie.vote_average!)"
        let request = URLRequest(url: URL(string: "\(prefixYoutube)\(movie.trailer!)")!)
        video.loadRequest(request)
        video.delegate = self
        time?.text = "\(movie.runtime!) min"
        genris?.text = movie.genres!
        let img = Downloader.downloadImageWithURL("\(prefixImage)w185\(self.movie.poster_path!)")
        posterImage.image = img
        let image = Downloader.downloadImageWithURL("\(prefixImage)w780\(self.movie.poster_path!)")
        UIGraphicsGetCurrentContext();
        self.view.backgroundColor = UIColor(patternImage: image!)
        
        UIGraphicsBeginImageContext(viewInTable.frame.size)
        UIImage(named: "03")!.draw(in: viewInTable.frame)
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
        
        //resize poster image when play youtube
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name.UIWindowDidBecomeKey,
            object: self.view.window,
            queue: nil
        ) { notification in
            print("Video stopped")
            self.posterImage.frame = CGRect(x: self.posterImage.frame.minX,y: self.video.frame.height ,width: (self.posterImage.image?.size.width)!*0.5, height:(self.posterImage.image?.size.height)!*0.4);
        }
    }
    func webViewDidFinishLoad(_ video: UIWebView) // here hide it
    {
        spinner.stopAnimating()
>>>>>>> origin/fbb
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Dispose of any resources that can be recreated.
    
<<<<<<< HEAD
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
=======
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
>>>>>>> origin/fbb
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
<<<<<<< HEAD
    override  func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
//    func tableView (tableView: UITableView, number indexPath: NSIndexPath) -> CGFloat
//    {
//        return 80
//    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
//    {
//        return 80
//    }
=======
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
>>>>>>> origin/fbb
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let day = Ngay[section]
        return day
    }
<<<<<<< HEAD

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "XuatChieu", for: indexPath) as UITableViewCell
        var f = indexPath.section
=======
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "XuatChieu", for: indexPath) as UITableViewCell
        let f = indexPath.section
        let weight = view.frame.size.width - 60
>>>>>>> origin/fbb
        if (f == 0)
        {
            let buttonWidth = 60
            let buttonSpace = 5
<<<<<<< HEAD
            for (index,ButtonText) in hourToday.enumerated(){
                
                let xCoord = CGFloat(index*buttonWidth + index*buttonSpace)
                
                let codedButton = codeButton(frame: CGRect(x:xCoord, y: 5, width: 50, height: 20)) 
=======
            for (index,_) in hourToday.enumerated(){
                var xCoord = 0
                var yCoord = 5
                if CGFloat(index*buttonWidth) < weight
                {
                    xCoord = index*buttonWidth + index*buttonSpace
                }
                else
                {
                    xCoord = 0
                    yCoord = 30
                }
                let codedButton = codeButton(frame: CGRect(x:xCoord, y: yCoord, width: 50, height: 20))
>>>>>>> origin/fbb
                codedButton.indexNgay=0
                codedButton.setTitle(hourToday[index].hour, for: UIControlState.normal)
                codedButton.tag = index
                codedButton.addTarget(self, action:#selector(self.buttonPressed), for: .touchUpInside)
                codedButton.setFormat()
<<<<<<< HEAD
                
=======
>>>>>>> origin/fbb
                cell.contentView.addSubview(codedButton)
            }
        }
        else
        {
            let buttonWidth = 60
            let buttonSpace = 5
<<<<<<< HEAD
            for (index,ButtonText) in hourTomorrow.enumerated(){
                
                let xCoord = CGFloat(index*buttonWidth + index*buttonSpace)
                
                let codedButton = codeButton(frame: CGRect(x:xCoord, y: 5, width: 50, height: 20))
=======
            for (index,_) in hourTomorrow.enumerated(){
                var xCoord = 0
                var yCoord = 5
                if CGFloat(index*buttonWidth) < weight
                {
                    xCoord = index*buttonWidth + index*buttonSpace
                }
                else
                {
                    xCoord = 0
                    yCoord = 30
                }
                let codedButton = codeButton(frame: CGRect(x:xCoord, y: yCoord, width: 50, height: 20))
>>>>>>> origin/fbb
                
                codedButton.indexNgay = 1
                codedButton.setTitle(hourTomorrow[index].hour, for: UIControlState.normal)
                codedButton.tag = index
                codedButton.addTarget(self, action:#selector(self.buttonPressed), for: .touchUpInside)
                codedButton.setFormat()
                
                cell.contentView.addSubview(codedButton)
            }
<<<<<<< HEAD

=======
            
>>>>>>> origin/fbb
        }
        return cell
    }
    
    //Button Action is
    func buttonPressed(sender:codeButton!)
    {
<<<<<<< HEAD
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicket") as! BuyTicket
=======
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "buyTicket") as! BuyTicketController
>>>>>>> origin/fbb
        srcBuyTicket.movie = movie
        srcBuyTicket.time = (sender.titleLabel?.text)!
        srcBuyTicket.indexNgay = sender.indexNgay
        srcBuyTicket.indexTime = sender.tag
        navigationController?.pushViewController(srcBuyTicket, animated: true)
        let buttonRow = sender.tag
        print("button is Pressed")
        print("Clicked Button Row is",buttonRow)
    }
    
<<<<<<< HEAD
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
=======
>>>>>>> origin/fbb
}
extension UIButton {
    
    func setFormat() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = CGFloat.init(10)
<<<<<<< HEAD
        self.layer.borderColor = UIColor.clear.cgColor
        self.backgroundColor = UIColor.black
=======
        //self.layer.borderColor = UIColor.white as! CGColor
        self.backgroundColor = UIColor.clear
>>>>>>> origin/fbb
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
}


class codeButton: UIButton {
    var indexNgay:            Int     = 0
}
<<<<<<< HEAD
=======


extension UIImage{
    
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
}
>>>>>>> origin/fbb
