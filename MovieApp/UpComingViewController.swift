//
//  NowPlayingViewController.swift
//  MovieApp-master
//
//  Created by miceli on 6/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase
class UpComingViewController: UITableViewController {
    
    var movies = [Movie]()
    var refreshPage = 0
    
    var p = 1
    var posterImage: [Int:UIImage] = [:]
    //Search
    let searchController = UISearchController(searchResultsController: nil)
    var filteredMovies = [Movie]()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        //spinner.isHidden = true
        loadData()
        self.tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "DetailMainCell", bundle: nil), forCellReuseIdentifier: "NowTVCell")
    }
    
    //
    func loadData()  {
        TMDb.getUpcomingListFireBase(completionHandler: { (movies, error) in
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
        if searchController.isActive && searchController.searchBar.text != "" {
            //Get from filteredMovies
            return filteredMovies.count
        }
        //Get from movies
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NowTVCell", for: indexPath) as! DetailMainCell
        let movie = self.movies[indexPath.row]
        cell.configWithCell(movie: movie)
        return cell
    }
    //Load lai data
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == refreshPage - 1 {
            //spinner.isHidden = false
            //spinner.startAnimating()
            loadData()
        }
    }
    //Handel event click cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "filmDetail") as! DetailController
        detailVC.movie = movies[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
