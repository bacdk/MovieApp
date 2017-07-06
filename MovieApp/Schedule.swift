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
    
    init(hour: String, seat: String) {
<<<<<<< HEAD
        self.hour            = hour as String?
        self.seat            = seat as String?
=======
        self.hour            = hour as String? ?? ""
        self.seat            = seat as String? ?? ""
>>>>>>> origin/fbb
    }
}
