//
//  Downloader.swift
//  TMDbDemo
//
//  Created by PhongLe on 5/12/17.
//  Copyright © 2017 PhongLe. All rights reserved.
//

import Foundation
import UIKit

class Downloader {
    
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
}
