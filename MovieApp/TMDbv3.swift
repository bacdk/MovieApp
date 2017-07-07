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
    static func getNowPlayListFireBase(completionHandler: @escaping (_ movies: [Movie]?, _ error: String?) -> Void){
        var listMovie = [Movie]()
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Movie").child("NowPlaying")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let movie = Movie(json: dictionary)
                listMovie.append(movie)
                completionHandler(listMovie, nil)
            }
            else
            {
                let error = "Movie list empty or problem when get data from firebase!"
                completionHandler(nil, error)
            }
        }, withCancel: nil)
        
    }
    //Get list upcoming movie
    static func getPopularListFireBase(completionHandler: @escaping (_ movies: [Movie]?, _ error: String?) -> Void){
        var listMovie = [Movie]()
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Movie").child("Popular")
        ref.observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let movie = Movie(json: dictionary)
                listMovie.append(movie)
                completionHandler(listMovie, nil)
            }
            else
            {
                completionHandler(nil, "Error retrieving data from server")
            }
            
        }, withCancel: nil)
    }
    
    //Get list upcoming movie
    static func getUpcomingListFireBase(completionHandler: @escaping (_ movies: [Movie]?, _ error: String?) -> Void){
        var listMovie = [Movie]()
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Movie").child("UpComing").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let movie = Movie(json: dictionary)
                listMovie.append(movie)
                completionHandler(listMovie, nil)
            }
            else
            {
                completionHandler(nil, "Error retrieving data from server")
            }
        }, withCancel: nil)
        
    }
    //Get ticket information
    static func getTicket(completionHandler: @escaping (_ tickets: [Ticket]?, _ error: String?) -> Void){
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
            else
            {
                completionHandler(nil, "Error retrieving data from server")
            }
        }, withCancel: nil)
        
    }
    //Get seat by real time
    static func getSeatMap(id: Int, ngay: String, gio: String, completionHandler: @escaping (_ seat: String?, _ error: String?) -> Void)
    {
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Movie").child(tabName).child(String(id)).child(ngay)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            print(tabName)
            if let seatJson = snapshot.value as? [String: Any] {
                //print(seat[gio])
                let seat = seatJson[gio] as! String
                //print(seat)
                completionHandler(seat, nil)
            }
            else
            {
                completionHandler(nil, "Error retrieving data from server")
            }
        }, withCancel: nil)
    }
    //Update seat
    static func updateSeat(id: Int, ngay: String, gio: String, seat: String, completionHandler: @escaping (_ error: Error?) -> Void)
    {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Movie").child("NowPlaying").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(String(id))
            {
                ref.child("Movie").child("NowPlaying").child(String(id)).child(ngay).updateChildValues(
                    [gio: seat], withCompletionBlock: { (err, ref) in
                        if let err = err {
                            completionHandler(err)
                            print(err)
                            return
                        }
                })
            }})
        ref.child("Movie").child("Popular").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(String(id))
            {
                ref.child("Movie").child("Popular").child(String(id)).child(ngay).updateChildValues(
                    [gio: seat], withCompletionBlock: { (err, ref) in
                        if let err = err {
                            completionHandler(err)
                            print(err)
                            return
                        }
                })
            }})
    }
    //Create User
    static func updateUserInfo(user: UserInfo, completionHandler: @escaping (_ error: Error?) -> Void)
    {
        let ref = Database.database().reference()
        let usersReference = ref.child("users").child(getUid())
        usersReference.updateChildValues(user.dict, withCompletionBlock: { (err, ref) in
            if let err = err {
                completionHandler(err)
                print(err)
                return
            }
        })
    }
    
    //Get data user
    static func fetchUser(completionHandler: @escaping (_ user: UserInfo, _ error: String?) -> Void){
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("users").child((Auth.auth().currentUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userData = snapshot.value as? [String : Any]
            {
                let user = UserInfo(json: userData)
                completionHandler(user, nil)
            }
            else
            {
                let user = UserInfo()
                completionHandler(user,"Error retrieving data from server")
            }
        }, withCancel: nil)
    }
    
    static func bookTicket(ticket: Ticket, completionHandler: @escaping (_ error: Error?) -> Void)
    {
        var ref: DatabaseReference!
        ref = Database.database().reference()
        let id = "\(String(ticket.id) ) \(ticket.day!) \(ticket.time!)"
        ref.child("users").child(getUid()).child("Tickets").child(id).setValue(ticket.dict)
        { (err, ref) -> Void in
            completionHandler(err)
            //print(err ?? <#default value#>)
            return
        }
    }
    static func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!
    }
    //reset password
    func resetPassword(email: String, completionHandler: @escaping (_ error: Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: { (error) in
            completionHandler(error)
        })
    }
}
