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
            
            if let movies = response?.Search {
                self.movies = movies.map(MovieViewModel.init)
            }
            
            if let error = response?.Error {
                self.error = error
            } else {
                self.error = ""
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

