

import Foundation
class MovieDetail {
    var adult: Bool!
    var backdrop_path: String!
    var belongs_to_collection: [String:Any]!
    var budget: Int!
    var genres: [String:Any]!
    var homepage: String!
    var id: Int!
    var imdb_id: String!
    var original_language: String!
    var original_title: String!
    var overview: String!
    var popularity: Double!
    var poster_path: String!
    var production_companies: [String:Any]!
    var production_countries: [String:Any]!
    var release_date: String!
    var revenue: Int!
    var runtime: Int!
    var spoken_languages: [Any]!
    var status: String!
    var tagline: String!
    var title: String!
    var video: Bool!
    var vote_average: Double!
    var vote_count: Int!
    
    init(json: [String:Any]) {
        adult = json["adult"] as! Bool
        
        backdrop_path = json["backdrop_path"] as! String
        
        belongs_to_collection = json["belongs_to_collection"] as! [String : Any]
        
        budget = json["budget"] as! Int
        
        genres = json["genres"] as! [String : Any]
        
        
        homepage = json["homepage"] as! String
        
        id = json["id"] as! Int
        
        imdb_id = json["imdb_id"] as! String
        
        original_language = json["original_language"] as! String
        
        original_title = json["original_title"] as! String
        
        overview = json["overview"] as! String
        
        popularity = json["popularity"] as! Double
        
        poster_path = json["poster_path"] as! String
        
        production_companies = json["production_companies"] as! [String : Any]
        
        production_countries = json["production_countries"] as! [String : Any]
        
        release_date = json["release_date"] as! String
        
        revenue = json["revenue"] as! Int
        
        runtime = json["runtime"] as! Int
        
        spoken_languages = json["spoken_languages"] as! [Any]
        
        status = json["status"] as! String
        
        tagline = json["tagline"] as! String
        
        video = json["video"] as! Bool
        
        vote_average = json["vote_average"] as! Double
        
        vote_count = json["vote_count"] as! Int
        
    }
    
}
