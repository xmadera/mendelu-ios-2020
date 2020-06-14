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
            } else {
                if let error = response?.Error {
                    self.error = error
                }
            }
        }
    }
    
    func getError() -> String? {
        if let myError = error {
            return myError
        }
        return nil
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

class FavoritesListViewModel: ObservableObject {
    @Published var movies = [MovieCDViewModel]()
    @Published var movie: MovieCD? = nil
    
    func createMovie(id: String, title: String, type: String, poster: String, year: String, actors: String, director: String, plot: String, genre: String) {
        CoreDataManager.shared.createMovie(imdbID: id, title: title, type: type, poster: poster, year: year, actors: actors, director: director, plot: plot, genre: genre)
    }
    
    func deleteMovie(movie: MovieCD) {
        CoreDataManager.shared.deleteMovie(movie: movie)
    }
    
    func loadMovies(tag: String) {
        self.movies = CoreDataManager.shared.getMovies(tag: tag).map(MovieCDViewModel.init)
    }
    
    func updateMovie(id: String, text: String) {
        CoreDataManager.shared.updateMovie(id: id, text: text)
    }
    
    func loadMovie(id: String) {
        self.movie = CoreDataManager.shared.getMovie(id: id)
    }
    
    func isInCoreData(tag: String, id: String) -> Bool {
        return CoreDataManager.shared.isInCoreData(tag: tag, id: id)
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


