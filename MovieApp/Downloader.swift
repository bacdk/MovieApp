//
//  DetailController.swift
//  MovieApp-master
//
//  Created by Tai Nhat Huynh on 6/10/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import Foundation
import UIKit


class Downloader {
    
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        if let cachedImage = imageCache.object(forKey: url as NSString) as? UIImage {
            return cachedImage
        }
        let data = try? Data(contentsOf: URL(string: url)!)
        return UIImage(data: data!)
    }
}
