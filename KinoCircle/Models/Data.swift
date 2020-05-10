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

struct Response: Codable {
    let Search: [Movie]
    let totalResults: String
    let Response: String
}


