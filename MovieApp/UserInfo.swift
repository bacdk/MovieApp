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
    init() {
     
    }
    init(json: [String: Any]) {
        self.name = json["name"] as? String
        self.email = json["email"] as? String
        self.password = json["password"] as? String
        self.profileImageUrl = json["profileImageUrl"] as? String ?? ""
    }
    
}
