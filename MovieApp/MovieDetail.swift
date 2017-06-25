

import Foundation
class MovieDetail {

    var genres: [AnyObject]!
    var runtime: Int!
    var genresarray : String!
    init(json: [String:Any]) {
        genresarray = ""
        genres = json["genres"] as! [AnyObject]
        runtime = json["runtime"] as! Int
        for i in genres
        {
            var dd = i as? [String:Any]
            let ddd = dd?["name"] as! String
            genresarray = genresarray + ddd + ", "
            //print(genresarray)
        }
    }
    var dict:[String:Any] {
        return [
            "genres": genresarray,
            "runtime": runtime,
        ]
    }
}
