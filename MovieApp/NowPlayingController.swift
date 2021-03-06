//
//  NowPlayingViewController.swift
//  MovieApp-master
//
//  Created by miceli on 6/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit
import Firebase

class NowPlayingController: UITableViewController{
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    //
    var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.tableView.separatorStyle = .none
        tabName="NowPlaying"
        tableView.register(UINib(nibName: "DetailMainCell", bundle: nil), forCellReuseIdentifier: "NowTVCell")
    }
    
    //
    override func viewDidAppear(_ animated: Bool)
    {
        spinner.center = tableView.center
    }
    
    //
    override func viewDidDisappear(_ animated: Bool) {
        spinner.stopAnimating()
    }
    
    //Load Data
    func loadData()  {
        TMDb.getNowPlayListFireBase(completionHandler: { (movies, error) in
            if(error != nil) {
                self.alertOK(message: error!, title: "Error")
                print(error!)
            } else {
                self.movies = movies!
                listmovieNP = movies!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NowTVCell", for: indexPath) as! DetailMainCell
        let movie = self.movies[indexPath.row]
        cell.configWithCell(movie: movie)
        return cell
    }
    
    //Handel event click cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "filmDetail") as! DetailController
        detailVC.movie = movies[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

