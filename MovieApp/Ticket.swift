//
//  Ticket.swift
//  MovieApp-master
//
//  Created by Zwart on 7/2/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

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
    //var realtime :String!
    init() {
        
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
        soghe          = json["soghe"]   as? [Int]! ?? []
        //realtime      = json["realtime"] as? String
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
            "soghe" : soghe,
            //"realtime" : realtime
        ]
    }
}
