//
//  DetailViewController.swift
//  MovieApp-master
//
//  Created by miceli on 6/4/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var overview: UITextView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var poster: UIImageView!
    var movieId: Int!
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print("info of \(movieId)")
        //        print("movie: \(movie.id)")
        
        //        let detail = TMDb.getDetail(ByMovieId: movieId!)
        //        print(detail)
        
        overview.text = movie.overview
        name.text = movie.title
        
        //        let imageKey = detail["backdrop_path"] as! String
        let queue = OperationQueue()
        queue.addOperation { () -> Void in
            let url = "\(prefixImage)w780\(String(describing: self.movie.backdrop_path ?? "nil"))"
            if let img = Downloader.downloadImageWithURL(url) {
                OperationQueue.main.addOperation({
                    self.poster.image = img
                })
            }
        }
    }
    //"\(prefixImage)w780\(self.movie.backdrop_path!)"
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
