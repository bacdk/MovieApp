//
//  SearchCell.swift
//  MovieApp-master
//
//  Created by Zwart on 6/24/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var ticket: UIImageView!
    var movie: Movie? {
        didSet {
            if let unwrappedMovie = movie {
                titleLabel.text = unwrappedMovie.title
                descriptionLabel.text = unwrappedMovie.overview
                if let poster = unwrappedMovie.poster_path{
                    let img = Downloader.downloadImageWithURL("\(prefixImage)w780\(poster)")
                    posterImageView.image = img
                } else {
                    posterImageView.image = UIImage(named: "default")
                }
                //print(unwrappedMovie.filmschedule)
                if unwrappedMovie.filmschedule != "UC"{
                    ticket.image = UIImage(named: "ticket1")
                } else {ticket.isHidden = true}
            }
        }
    }
    
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            backgroundColor = UIColor.clear
            posterImageView.layer.shadowOpacity = 0.4
            posterImageView.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

}
