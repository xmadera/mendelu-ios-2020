//
//  MovieViewModel.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation

struct MovieViewModel {
    var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var imdbID: String {
        return self.movie.imdbID
    }
    
    var title: String {
        return self.movie.Title
    }
    
    var year: String {
        return self.movie.Year
    }
    
    var type: String {
        return self.movie.Type
    }
    
    var poster: String {
        return self.movie.Poster
    }
    
}
