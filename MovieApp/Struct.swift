//
//  DetailController.swift
//  MovieApp-master
//
//  Created by Tai Nhat Huynh on 6/10/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import Foundation
let apiKey = "api_key=bf144d99969c3e174c395faf9782475d"
let prefixLink = "https://api.themoviedb.org/3/movie/"
let language = "language=en-US"
let prefixImage = "https://image.tmdb.org/t/p/"
let prefixYoutube = "https://www.youtube.com/embed"
let prefixWebInfo = "https://www.themoviedb.org/movie/"
let seatMap:String =   "_DDDDDD_DDDDDD_DDDDDDDD_/" +
    "_AAAAAA_AAAAAA_AAAAAAAA_/" +
    "________________________/" +
    "_AAAAAAAAAAAAAAAAAAAAAAA/" +
    "_AAAAAAAAAAAAAAAAAAAAAAA/" +
    "_AAAAAAAAAAAAAAAAAAAAAAA/" +
    "_AAAAAAAAAAAAAAAAAAAAAAA/" +
"_AAAAAAAAAAAAAAAAAAAAAAA/"
<<<<<<< HEAD
var seatMapFireBase:String =   ""
var tabName = ""
=======
let profileDefaultImage = "https://firebasestorage.googleapis.com/v0/b/movieapp-12783.appspot.com/o/default%2Fcorn.png?alt=media&token=7cdbfb10-ffc5-4bb5-909b-eb82c9bfca0b"
var seatMapFireBase:String =   ""
var tabName = ""
var listmovieNP = [Movie]()
var listmoviePP = [Movie]()
var listmovieUC = [Movie]()
var listmovieTotal = [Movie]()
var userInfo = UserInfo()
>>>>>>> origin/fbb
