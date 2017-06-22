

import Foundation
class MovieDetail {

    var genres: [NSArray]!
    var runtime: Int!
    
    init(json: [String:Any]) {
        genres = json["genres"] as! [NSArray]
        runtime = json["runtime"] as! Int
    }
    var dict:[String:Any] {
        return [
            "genres": genres,
            "runtime": runtime,
        ]
    }
}
