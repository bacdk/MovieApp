//
//  DetailMainCell.swift
//  MovieApp-master
//
//  Created by Zwart on 6/22/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class DetailMainCell: UITableViewCell {

    @IBOutlet weak var imageBack: UIImageView!
    @IBOutlet weak var lblRelease: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    func configWithCell(movie: Movie) {
        lblTittle.text = movie.title
        lblRelease.text = movie.release_date
        imageBack.image = #imageLiteral(resourceName: "default")
        let img1 = Downloader.downloadImageWithURL("\(prefixImage)w780\(movie.backdrop_path!)")
        lblTittle.text = lblTittle.text?.uppercased()
        imageBack.image = img1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
