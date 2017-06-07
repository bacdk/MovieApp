//
//  UpComingTVCell.swift
//  MovieApp-master
//
//  Created by Cntt22 on 6/7/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class UpComingTVCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
