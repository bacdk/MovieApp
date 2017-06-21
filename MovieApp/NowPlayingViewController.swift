//
//  NowPlayingViewController.swift
//  MovieApp-master
//
//  Created by miceli on 6/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase

class NowPlayingViewController: UITableViewController, UISearchResultsUpdating{
    
    
    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var viewIU: UIView!
    //
    var movies = [Movie]()
    var refreshPage = 0
    //
    var p = 1
    var posterImage: [Int:UIImage] = [:]
    //Search
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tableView.separatorStyle = .none
        //Search
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        self.view.addSubview(searchController.searchBar)
        definesPresentationContext = true
        tabName="NowPlaying"
   
    }
    
    //Load Data
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
    
    //Search
    //
    func filterContentForSearchText(searchText: String) {
        filteredMovies = movies.filter { movie in
            return  movie.title.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    //
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredMovies.count
        }
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NowTVCell", for: indexPath) as! NowPlayingTVCell
        cell.posterImage.image = #imageLiteral(resourceName: "default")
        let queue = OperationQueue()
        //
        if searchController.isActive && searchController.searchBar.text != "" {
            if posterImage[filteredMovies[indexPath.row].id] != nil {
                cell.posterImage.image = posterImage[filteredMovies[indexPath.row].id]
            }else{
                queue.addOperation { () -> Void in
                    let img1 = Downloader.downloadImageWithURL("\(prefixImage)w185\(self.filteredMovies[indexPath.row].poster_path!)")
                    // NSLog(img1)
                    OperationQueue.main.addOperation({
                        self.posterImage[self.filteredMovies[indexPath.row].id] = img1
                        cell.posterImage.image = img1
                    })
                }
            }
            //
            cell.nameLabel.text = filteredMovies[indexPath.row].title
            //cell.overviewTextView.text = filteredMovies[indexPath.row].overview
            cell.releaseLabel.text = "📅 \(filteredMovies[indexPath.row].release_date!)"
            cell.voteLabel.text = "★ \(filteredMovies[indexPath.row].vote_average!)"
        } else {
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
            //
            cell.nameLabel.text = movies[indexPath.row].title
            
            cell.releaseLabel.text = "📅 \(movies[indexPath.row].release_date!)"
            cell.voteLabel.text = "★ \(movies[indexPath.row].vote_average!)"
        }
        //
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
