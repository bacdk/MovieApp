//
<<<<<<< HEAD
//  File.swift
//  MovieApp-master
//
//  Created by Cntt22 on 6/14/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

=======
//  Ticket.swift
//  MovieApp-master
//
//  Created by Zwart on 7/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

>>>>>>> origin/fbb
import Foundation

class Ticket{
    var id  :Int!
    var name:String!
    var image:String!
    var day :String!
    var time:String!
    var seat:String!
    var sove:Int64!
    var tongtien: Int64!
    var soghe :   [Int]!
<<<<<<< HEAD
    init() {

=======
    //var realtime :String!
    init() {
        
>>>>>>> origin/fbb
    }
    init(json: [String:Any]) {
        id             = json["id"]       as? Int
        name           = json["name"]     as? String
        image          = json["image"]    as? String
        day            = json["day"]      as? String
        time           = json["time"]     as? String
        seat           = json["seat"]     as? String
        sove           = json["sove"]     as? Int64!
        tongtien       = json["tongtien"] as? Int64!
<<<<<<< HEAD
        soghe          = json["soghe"]   as? [Int]!
=======
        soghe          = json["soghe"]   as? [Int]! ?? []
        //realtime      = json["realtime"] as? String
>>>>>>> origin/fbb
    }
    
    var dict:[String:Any] {
        return [
            "id": id,
            "name": name,
            "image": image,
            "day":day,
            "time":time,
            "seat":seat,
            "sove":sove,
            "tongtien":tongtien,
<<<<<<< HEAD
            "soghe" : soghe
=======
            "soghe" : soghe,
            //"realtime" : realtime
>>>>>>> origin/fbb
        ]
    }
}
