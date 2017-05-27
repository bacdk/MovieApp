//
//  NowPlayingTVController.swift
//  MovieApp
//
//  Created by Cntt22 on 5/27/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class NowPlayingTVController: UITableViewController {

    var movies = [Movie]()
    
    var posterImage: [Int:UIImage] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        //HUD.flash(.labeledProgress(title: "Please wait", subtitle: "loading data"), delay: 3)
        let jsonListMovie = TMDb.getNowPlayList(InPage: 1)
        for movie in jsonListMovie {
            movies.append(Movie(json: movie as! [String:Any]))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! NowPlayingTVCell
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
        if segue.identifier == "showDetail" {
            
            }
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
