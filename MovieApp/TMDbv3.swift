
import Foundation

class TMDb {
    
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
                    listMovie = json["results"] as! [Any]
                } catch let error as NSError {
                    print(error)
                }
            }
        }).resume()
        sleep(3)
        return listMovie
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
