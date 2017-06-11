//
//  File.swift
//  MovieApp-master
//
//  Created by Tai Nhat Huynh on 6/11/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import Foundation
class Schedule {
    
    var hour: String?
    var seat: String?
    
    init(json: [String:Any]) {
        hour            = json["poster_path"]       as? String
        seat            = json["adult"]             as? String
    }
}
