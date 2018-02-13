//
//  Movie.swift
//  Flix
//
//  Created by Rohan Gupta on 2/11/18.
//  Copyright © 2018 Rohan Gupta. All rights reserved.
//

import Foundation
class Movie {
    var title: String
    var posterUrl: URL?
    var overview: String
    var posterUrlStr: String
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        posterUrlStr = dictionary["poster_path"] as? String ?? "No url"
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let finalURL = baseURLString + posterUrlStr
        posterUrl = URL(string: finalURL)
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
