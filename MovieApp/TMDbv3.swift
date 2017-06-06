
import Foundation
import Firebase
import FirebaseDatabase
class TMDb {
    static func getNowPlayListFireBase()
    {
        var listMovie = [Any]()
        var ref: DatabaseReference!
       // var databaseHandle:DatabaseHandle?
        ref = Database.database().reference()
        ref.child("Movie").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            //self.listMovie.append(snapshot.value) as! [String : AnyObject]
            if let identities = snapshot.value! as? [String:AnyObject]{
                for each in identities as [String:AnyObject]{
                    listMovie.append(each)//will append medals
                }
            }
            
            //            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
//            let user = User.init(username: username)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
     //   return listMovie

        
        
        
        
        
        
        
        
        
        
//        var listMovie = [Any]()
//        
//        DatabaseHandle = ref?.child("Movie").observe(.childAdded, with: { (snapshot) in
//            listMovie = self.listMovie.a
//        })
        
        
        
        
        
        // ref = Database.database().reference()
        //let ref = Database.database().reference().child("users").child("user").child(username)
        
            //Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            //dư lieu get ve nam trong snapshot
            //if let dictionary = snapshot.value as? [String: AnyObject] {
              //  let user = UserInfo(dictionary: dictionary)
                //self.users.append(user)
        //}
    }
    static func getNowPlayList(InPage page: Int) -> [Any] {
        var json = [String:Any]()
        var listMovie = [Any]()
        let url = NSURL(string: "\(prefixLink)now_playing?\(apiKey)&\(language)&page=\(page)")
        
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 3)
        
        request.httpMethod = "GET"
        _ = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (Data, URLResponse, Error) in
            
            if (Error != nil) {
                print(Error!)
            } else {
                
                do {
                    json = try JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as! [String:Any]
                    //cái khúc này nè 
                    listMovie = json["results"] as! [Any]
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
        sleep(3)
        return listMovie //json đã ép về mảng type Any
    }
    
    static func getComingList(InPage page: Int) -> [Any] {
        var json = [String:Any]()
        var listMovie = [Any]()
        let url = NSURL(string: "\(prefixLink)upcoming?\(apiKey)&\(language)&page=\(page)")
        
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 3)
        
        request.httpMethod = "GET"
        _ = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (Data, URLResponse, Error) in
            
            if (Error != nil) {
                print(Error!)
            } else {
                
                do {
                    json = try JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as! [String:Any]
                    listMovie = json["results"] as! [Any]
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
        sleep(3)
        return listMovie
    }
    static func getPopularList(InPage page: Int) -> [Any] {
        var json = [String:Any]()
        var listMovie = [Any]()
        let url = NSURL(string: "\(prefixLink)popular?\(apiKey)&\(language)&page=\(page)")
        
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 3)
        
        request.httpMethod = "GET"
        _ = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (Data, URLResponse, Error) in
            
            if (Error != nil) {
                print(Error!)
            } else {
                
                do {
                    json = try JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as! [String:Any]
                    listMovie = json["results"] as! [Any]
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
        sleep(3)
        return listMovie
    }
    

    static func getDetail(ByMovieId id: Int) -> [String:Any] {
        print("\(prefixLink)\(id)?\(apiKey)&\(language)")
        let url = NSURL(string: "\(prefixLink)\(id)?\(apiKey)&\(language)")
        var json = [String:Any]()
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 3)
        
        request.httpMethod = "GET"

        _ = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (Data, URLResponse, Error) in
            
            if (Error != nil) {
                print(Error!)
            } else {
                
                do {
                    json = try JSONSerialization.jsonObject(with: Data!, options: .allowFragments) as! [String:Any]
                    
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
        sleep(3)
        return json
        
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
