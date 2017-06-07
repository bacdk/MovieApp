//
//  UpComingTVController.swift
//  MovieApp-master
//
//  Created by Cntt22 on 6/7/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
    import Firebase
    class UpComingTVController: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var spinner: UIActivityIndicatorView!
        var movies = [Movie]()
        var refreshPage = 0
        
        var p = 1
        var posterImage: [Int:UIImage] = [:]
        override func viewDidLoad() {
            super.viewDidLoad()
            //HUD.flash(.labeledProgress(title: "Please wait", subtitle: "loading data"), delay: 3)
            //let jsonListMovie = TMDb.getNowPlayList(InPage: 1)
            spinner.isHidden = true
            loadMovie(page: p)
            self.tableView.separatorStyle = .none
            self.tableView.dataSource = self
            self.tableView.delegate = self
            //load()
        }
              // MARK: - Table view data source
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return movies.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UpCell", for: indexPath) as! UpComingTVCell
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
            //var segment = [ChartSegment]()
            //segment.append(ChartSegment(value: movies[indexPath.row].vote_average, description: "%"))
            cell.releaseLabel.text = "📅 \(movies[indexPath.row].release_date!)"
            cell.voteLabel.text = "⭐️ \(movies[indexPath.row].vote_average!)"
            return cell
        }
        //Load lai data
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.row == refreshPage - 1 {
                spinner.isHidden = false
                spinner.startAnimating()
                loadMovie(page: p)
            }
        }
        func loadMovie(page: Int)
        {
            let jsonListMovie = TMDb.getNowPlayList(InPage: p)
            for movie in jsonListMovie {
                movies.append(Movie(json: movie as! [String:Any]))
            }
            var ref: DatabaseReference!
            ref = Database.database().reference()
            for movie in jsonListMovie {
                var json = movie as! [String:Any]
                var id: Int!
                id = json["id"] as? Int
                ref.child("Movie").child("UpComing").child(String(id)).setValue(movie)
                
                // File located on disk
                let img1 = Downloader.downloadImageWithURL("\(prefixImage)w185\(json["poster_path"]!)")
                //print((json["poster_path"])!)
                // Create a reference to the file you want to upload
                let storageRef = Storage.storage().reference().child("movie_images").child(json["poster_path"] as! String)
                // Upload the file to the path "images/rivers.jpg"
                if let uploadData = UIImagePNGRepresentation(img1!) {
                    storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                        if let error = error {
                            print(error)
                            return
                        }})
                }
            }
            DispatchQueue.main.async {
                self.refreshPage += 20
                self.tableView.reloadData()
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                //self.loadingData = false
                self.p += 1
            }
        }
        // MARK: - Segues
        // MARK: - Segues
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail" {
                if let indexPath = tableView.indexPathForSelectedRow {
                    //data send to detail view
                    
                    
                    let detailVC = segue.destination as! DetailViewController
                    detailVC.movie = movies[indexPath.row]
                    let queue = OperationQueue()
                    queue.addOperation { () -> Void in
                        var listVideo: [Trailer]!
                        listVideo = TMDb.getListTrailer(by: self.movies[indexPath.row].id!)
                        detailVC.listVideos = listVideo
                        //print(listVideo)
                        //print(self.movies[indexPath.row].id)
                    }
                }
            }
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

