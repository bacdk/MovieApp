//
//  NowPlayingViewController.swift
//  MovieApp-master
//
//  Created by miceli on 6/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var movies = [Movie]()
    
    var posterImage: [Int:UIImage] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        //HUD.flash(.labeledProgress(title: "Please wait", subtitle: "loading data"), delay: 3)
        //let jsonListMovie = TMDb.getNowPlayList(InPage: 1)
        let jsonListMovie = TMDb.getComingList(InPage: 1)
        for movie in jsonListMovie {
            movies.append(Movie(json: movie as! [String:Any]))
        }
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NowTVCell", for: indexPath) as! NowPlayingTVCell
        //        var queue = OperationQueue()
        //        let operation1 = BlockOperation(block: {
        //            let img1 = Downloader.downloadImageWithURL("\(preImage)\(self.movies[indexPath.row].poster_path)")
        //            OperationQueue.main.addOperation({
        //                cell.posterImage.image = img1
        //            })
        //        })
        
        var queue = OperationQueue()
        if posterImage[movies[indexPath.row].id] != nil {
            cell.posterImage.image = posterImage[movies[indexPath.row].id]
        }else{
            queue.addOperation { () -> Void in
                let img1 = Downloader.downloadImageWithURL("\(prefixImage)w185\(self.movies[indexPath.row].poster_path!)")
                OperationQueue.main.addOperation({
                    self.posterImage[self.movies[indexPath.row].id] = img1
                    cell.posterImage.image = img1
                })
            }
        }
        
        cell.nameLabel.text = movies[indexPath.row].title
        cell.overviewTextView.text = movies[indexPath.row].overview
        //var segment = [ChartSegment]()
        //segment.append(ChartSegment(value: movies[indexPath.row].vote_average, description: "%"))
        cell.releaseLabel.text = "📅 \(movies[indexPath.row].release_date!)"
        cell.voteLabel.text = "⭐️ \(movies[indexPath.row].vote_average!)"
        return cell
    }
    
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "showDetail" {
        
        //  }
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

