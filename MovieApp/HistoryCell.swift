//
//  HistoryCell.swift
//  MovieApp-master
//
//  Created by Zwart on 6/21/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {
<<<<<<< HEAD
=======
   
>>>>>>> origin/fbb
    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var poster: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
<<<<<<< HEAD
=======
    @IBOutlet weak var viewCell: UIView!{
        didSet {
            viewCell.layer.shadowOpacity = 0.4
            viewCell.layer.shadowOffset = CGSize(width: 3.0, height: 2.0)
        }
    }
>>>>>>> origin/fbb

}
