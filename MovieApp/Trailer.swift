//
//  Trailer.swift
//  TMDbDemo
//
//  Created by PhongLe on 5/13/17.
//  Copyright © 2017 PhongLe. All rights reserved.
//

import Foundation

class Trailer {

    var key: String?
    
    init(json: [String:Any]) {
        key         = json["key"]           as? String ?? ""

    }
    var dict:[String:Any] {
        return [
            "trailer": "/\(key!)"
        ]
    }
}
