//
//  DetailController.swift
//  MovieApp-master
//
//  Created by Tai Nhat Huynh on 6/10/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
class TMDb {
    //Get list nowplaying movie
    static func getNowPlayListFireBase(completionHandler: @escaping (_ movies: [Movie]?, _ error: Error?) -> Void){
        var listMovie = [Movie]()
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Movie").child("NowPlaying")
        ref.observe(.childAdded, with: { (snapshot) in
            var today = [Schedule]()
            var tomorrow = [Schedule]()
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let movie = Movie(json: dictionary)
                for child in snapshot.childSnapshot(forPath: "Today").children
                {
                    today.append(Schedule(hour: (child as! DataSnapshot).key, seat: (child as! DataSnapshot).value as! String))
                }
                for child in snapshot.childSnapshot(forPath: "Tomorrow").children
                {
                    tomorrow.append(Schedule(hour: (child as! DataSnapshot).key, seat: (child as! DataSnapshot).value as! String))
                }
                movie.today=today
                movie.tomorrow=tomorrow
                listMovie.append(movie)
                completionHandler(listMovie, nil)
            }
            
        }, withCancel: nil)
        
    }
    //Get list upcoming movie
    static func getPopularListFireBase(completionHandler: @escaping (_ movies: [Movie]?, _ error: Error?) -> Void){
        var listMovie = [Movie]()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Movie").child("Popular").observe(.childAdded, with: { (snapshot) in
            
            var today = [Schedule]()
            var tomorrow = [Schedule]()
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let movie = Movie(json: dictionary)
                for child in snapshot.childSnapshot(forPath: "Today").children
                {
                    today.append(Schedule(hour: (child as! DataSnapshot).key, seat: (child as! DataSnapshot).value as! String))
                }
                for child in snapshot.childSnapshot(forPath: "Tomorrow").children
                {
                    tomorrow.append(Schedule(hour: (child as! DataSnapshot).key, seat: (child as! DataSnapshot).value as! String))
                }
                movie.today=today
                movie.tomorrow=tomorrow
                listMovie.append(movie)
                completionHandler(listMovie, nil)
            }
            
        }, withCancel: nil)
        
    }
    //Get list upcoming movie
    static func getUpcomingListFireBase(completionHandler: @escaping (_ movies: [Movie]?, _ error: Error?) -> Void){
        var listMovie = [Movie]()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Movie").child("UpComing").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let movie = Movie(json: dictionary)
                listMovie.append(movie)
                
                completionHandler(listMovie, nil)
            }
            
        }, withCancel: nil)
        
    }
    static func getUpComingListFireBase(by movieId: Int) -> [Any] {
        var json = [String:Any]()
        var listTrailer = [Any]()
        let url = NSURL(string: "\(prefixLink)\(movieId)/videos?\(apiKey)&\(language)")
        
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 3)
        
        request.httpMethod = "GET"
        
        _ = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (Data, URLResponse, Error) in
            
            if (Error != nil) {
                print(Error!)
            } else {
                
                do {
                    json = try JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as! [String:Any]
                    listTrailer = json["results"] as! [Any]
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
        sleep(3)
        return listTrailer
    }
    static func getTrailerSet(by movieId: Int) -> [Any] {
        var json = [String:Any]()
        var listTrailer = [Any]()
        let url = NSURL(string: "\(prefixLink)\(movieId)/videos?\(apiKey)&\(language)")
        
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 3)
        
        request.httpMethod = "GET"
        
        _ = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (Data, URLResponse, Error) in
            
            if (Error != nil) {
                print(Error!)
            } else {
                
                do {
                    json = try JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as! [String:Any]
                    listTrailer = json["results"] as! [Any]
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
        sleep(3)
        return listTrailer
    }
    static func getListTrailer(by movieId: Int) -> [Trailer] {
        let set = getTrailerSet(by: movieId)
        var trailers = [Trailer]()
        
        for video in set {
            let temp = video as! [String:Any]
            trailers.append(Trailer(json: temp))
        }
        
        return trailers
    }
}
