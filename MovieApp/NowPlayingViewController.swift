//
//  NowPlayingViewController.swift
//  MovieApp-master
//
//  Created by miceli on 6/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase

class NowPlayingViewController: UITableViewController{
    

    var movies = [Movie]()
    var refreshPage = 0
    
    var p = 1
    var posterImage: [Int:UIImage] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tableView.separatorStyle = .none       
    }
    func loadData()  {
        TMDb.getNowPlayListFireBase(completionHandler: { (movies, error) in
            if(error != nil) {
                print(error!)
            } else {
                self.movies = movies!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NowTVCell", for: indexPath) as! NowPlayingTVCell
        cell.posterImage.image = #imageLiteral(resourceName: "default")
        let queue = OperationQueue()
        if posterImage[movies[indexPath.row].id] != nil {
            cell.posterImage.image = posterImage[movies[indexPath.row].id]
        }else{
            queue.addOperation { () -> Void in
                let img1 = Downloader.downloadImageWithURL("\(prefixImage)w185\(self.movies[indexPath.row].poster_path!)")
               // NSLog(img1)
                OperationQueue.main.addOperation({
                    self.posterImage[self.movies[indexPath.row].id] = img1
                    cell.posterImage.image = img1
                })
            }
        }
        
        cell.nameLabel.text = movies[indexPath.row].title
        cell.overviewTextView.text = movies[indexPath.row].overview
        cell.releaseLabel.text = "📅 \(movies[indexPath.row].release_date!)"
        cell.voteLabel.text = "⭐️ \(movies[indexPath.row].vote_average!)"
        return cell
    }
    //Load lai data
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == refreshPage - 1 {
            loadData()
        }
    }
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //data send to detail view
                let detailVC = segue.destination as! DetailController
                detailVC.movie = movies[indexPath.row]

                    var listVideo: [Trailer]!
                    listVideo = TMDb.getListTrailer(by: self.movies[indexPath.row].id!)
                    detailVC.listVideos = listVideo

            }
        }
    }

}
