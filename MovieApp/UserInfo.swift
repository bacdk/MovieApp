//
//  DetailController.swift
//  MovieApp-master
//
//  Created by Tai Nhat Huynh on 6/10/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

class UserInfo{
    var name: String?
    var email: String?
    var password: String?
    var profileImageUrl: String?
    var address : String?
    var birthday : String?
    var phone: String?
    init() {
     
    }
    init(json: [String: Any]) {
        self.name = json["name"] as? String
        self.email = json["email"] as? String
        self.password = json["password"] as? String
        self.profileImageUrl = json["profileImageUrl"] as? String ?? ""
        self.address = json["address"] as? String ?? ""
        self.birthday = json["birthday"] as? String ?? ""
        self.phone = json["phone"] as? String ?? ""

    }
    var dict:[String:Any] {
        return [
            "name" : name ?? "",
            //"profileImageUrl"
            "address" : address ?? "",
            "birthday" : birthday ?? "",
            "phone" : phone ?? ""
        ]
    }
}
