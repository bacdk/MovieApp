//
//  DetailController.swift
//  MovieApp-master
//
//  Created by Tai Nhat Huynh on 6/10/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class DetailController: UITableViewController {
    
    @IBOutlet weak var video: UIWebView!
    @IBOutlet weak var nameMovie: UILabel!
    @IBOutlet weak var overview: UITextView!
    var movieId: Int!
    var movie: Movie!
    var listVideos = [Trailer]()
    
    
    var hourToday = [Schedule]()
    var hourTomorrow = [Schedule]()
    var Ngay=["Today", "Tomorrow"]
    
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
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Dispose of any resources that can be recreated.
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let day = Ngay[section]
        return day
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "XuatChieu", for: indexPath) as UITableViewCell
        var f=indexPath.section
        if (f == 0)
        {
            let buttonWidth = 60
            let buttonSpace = 5
            for (index,ButtonText) in hourToday.enumerated(){
                
                let xCoord = CGFloat(index*buttonWidth + index*buttonSpace)
                
                let codedButton:UIButton = UIButton(frame: CGRect(x:xCoord, y: 5, width: 50, height: 20))
                
                
                codedButton.layer.borderWidth = 1
                codedButton.layer.cornerRadius = CGFloat.init(10)
                codedButton.layer.borderColor = UIColor.clear.cgColor 
                codedButton.backgroundColor = UIColor.black
                codedButton.setTitle(hourToday[index].hour, for: UIControlState.normal)
                codedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
                
                codedButton.addTarget(self, action:#selector(self.buttonPressed), for: .touchUpInside)
                codedButton.tag = index
                
                cell.contentView.addSubview(codedButton)
            }
        }
        else
        {
            let buttonWidth = 60
            let buttonSpace = 5
            for (index,ButtonText) in hourTomorrow.enumerated(){
                
                let xCoord = CGFloat(index*buttonWidth + index*buttonSpace)
                
                let codedButton:UIButton = UIButton(frame: CGRect(x:xCoord, y: 5, width: 50, height: 20))
                
                
                codedButton.layer.borderWidth = 1
                codedButton.layer.cornerRadius = CGFloat.init(10)
                codedButton.layer.borderColor = UIColor.clear.cgColor
                codedButton.backgroundColor = UIColor.black
                codedButton.setTitle(hourTomorrow[index].hour, for: UIControlState.normal)
                codedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)

                
                codedButton.addTarget(self, action:#selector(self.buttonPressed), for: .touchUpInside)
                codedButton.tag = index
                
                cell.contentView.addSubview(codedButton)
            }

        }
        return cell
    }
    
    //Button Action is
    func buttonPressed(sender:UIButton!)
    {
        let buttonRow = sender.tag
        print("button is Pressed")
        print("Clicked Button Row is",buttonRow)
    }
    
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
    
}
