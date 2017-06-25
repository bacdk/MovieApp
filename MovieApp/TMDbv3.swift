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
                movie.today = today 
                movie.tomorrow = tomorrow
                listMovie.append(movie)
                completionHandler(listMovie, nil)
            }
        }, withCancel: nil)
        
    }
    //Get list upcoming movie
    static func getPopularListFireBase(completionHandler: @escaping (_ movies: [Movie]?, _ error: Error?) -> Void){
        var listMovie = [Movie]()
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Movie").child("Popular")
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
                movie.today = today
                movie.tomorrow = tomorrow
                listMovie.append(movie)
                completionHandler(listMovie, nil)
            }
            
        }, withCancel: nil)
        
    }
    //Get ìnormation ticket
    static func getTicket(completionHandler: @escaping (_ tickets: [Ticket]?, _ error: Error?) -> Void){
        var listTicket = [Ticket]()
        var ref: DatabaseReference!
        ref = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!).child("Tickets")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let ticket = Ticket(json: dictionary)
                //print(ticket.id)
                listTicket.append(ticket)
                completionHandler(listTicket, nil)
            }
        }, withCancel: nil)
        
    }
    //Get list upcoming movie
    static func getUpcomingListFireBase(completionHandler: @escaping (_ movies: [Movie]?, _ error: Error?) -> Void){
        var listMovie = [Movie]()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Movie").child("UpComing").observe(.childAdded, with: { (snapshot) in
            let today = [Schedule]()
            let tomorrow = [Schedule]()
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let movie = Movie(json: dictionary)
                listMovie.append(movie)
                movie.today=today
                movie.tomorrow=tomorrow
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
    static func getSeatMap(id: Int, ngay: String, gio: String, completionHandler: @escaping (_ seat: String?, _ error: Error?) -> Void)
    {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Movie").child(tabName).child(String(id)).child(ngay)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(tabName)
            let seatJson = snapshot.value as! [String: Any]
            //print(seat[gio])
            let seat = seatJson[gio] as! String
            //print(seat)
            completionHandler(seat, nil)
        }, withCancel: nil)
    }
    static func updateSeat(id: Int, ngay: String, gio: String, seat: String)
    {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Movie").child("NowPlaying").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(String(id))
            {
                ref.child("Movie").child("NowPlaying").child(String(id)).child(ngay).updateChildValues([
                    gio: seat])
            }
        }, withCancel: nil)
        ref.child("Movie").child("Popular").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(String(id))
            {
                ref.child("Movie").child("Popular").child(String(id)).child(ngay).updateChildValues([
                    gio: seat])
            }
        }, withCancel: nil)
    }
    
    static func fetchUser(completionHandler: @escaping (_ user: UserInfo, _ error: Error?) -> Void){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            let user = UserInfo(json: snapshot.value as! [String : Any])
            completionHandler(user, nil)
        }, withCancel: nil)
    }
    
    static func bookTicket(ticket: Ticket)
    {
        var ref: DatabaseReference!
        ref = Database.database().reference()
            let id = "\(String(ticket.id) ) \(ticket.day!) \(ticket.time!)"
            ref.child("users").child(getUid()).child("Tickets").child(id).setValue(ticket.dict)
    
    }
    static func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!
    }
    
    static func getTest(completionHandler: @escaping (_ movies: [Movie]?, _ error: Error?) -> Void){
        var listMovie = [Movie]()
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Movie")
        ref.observe(.childAdded, with: { (snapshot) in
            var today = [Schedule]()
            var tomorrow = [Schedule]()
            if let dictionary = snapshot.childSnapshot(forPath: "NowPlaying").value as? [String: AnyObject]
            {
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
                listmovieNP = listMovie
                completionHandler(listMovie, nil)
            }
            
        }, withCancel: nil)
        
    }

    
}
