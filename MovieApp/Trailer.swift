//
//  Trailer.swift
//  TMDbDemo
//
//  Created by PhongLe on 5/13/17.
//  Copyright © 2017 PhongLe. All rights reserved.
//

import Foundation

class Trailer {
    var id: String?
    var iso_639_1: String?
    var iso_3166_1: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
    
    init(json: [String:Any]) {
        id          = json["id"]            as? String
        iso_639_1   = json["iso_639_1"]     as? String
        iso_3166_1  = json["iso_3166_1"]    as? String
        key         = json["key"]           as? String
        name        = json["name"]          as? String
        site        = json["site"]          as? String
        size        = json["size"]          as? Int
        type        = json["type"]          as? String
    }
}
