//
//  PostListViewModel.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation

class MovieListViewModel: ObservableObject {
    @Published var movies = [MovieViewModel]()
    @Published var error: String? = nil
    
    func loadMovies(paramTitle: String, tag: String) {
        MainWebservice().getMovies(paramTitle: paramTitle, tag: tag) { response in
            
            self.error = nil
            self.movies = []
            if let movies = response?.Search {
                self.movies = movies.map(MovieViewModel.init)
            }
            if let error = response?.Error {
                self.error = error
            }
        }
    }
}

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

struct MovieCDViewModel {
    var movie: MovieCD
    
    init(movie: MovieCD) {
        self.movie = movie
    }
    
    var imdbID: String {
        return self.movie.imdbID!
    }
    
    var title: String {
        return self.movie.title!
    }
    
    var year: String {
        return self.movie.year!
    }
    
    var type: String {
        return self.movie.type!
    }
    
    var poster: String {
        return self.movie.poster!
    }
}


