//
//  Data.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation

struct Movie: Codable {
    let imdbID: String
    var Title: String
    var Year: String
    var `Type`: String
    var Poster: String
}

struct ResponseList: Codable {
    let Search: [Movie]?
    let totalResults: String?
    let Response: String
    let Error: String?
}

struct Rating: Codable, Hashable {
    let Source: String
    let Value: String
}

struct MovieDetail: Codable {
    let imdbID: String?
    var Title: String?
    var Year: String?
    var Rated: String?
    var Released: String?
    var Runtime: String?
    var Genre: String?
    var Director: String?
    var Writer: String?
    var Actors: String?
    var Plot: String?
    var Language: String?
    var Country: String?
    var Award: String?
    var Ratings: [Rating]?
    var Metascore: String?
    var imdbRating: String?
    var imdbVotes: String?
    var DVD: String?
    var BoxOffice: String?
    var Production: String?
    var Website: String?
    var `Type`: String?
    var Poster: String?
    let Error: String?
    let Response: String
}

