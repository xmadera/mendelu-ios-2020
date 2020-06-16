//
//  MovieDetailViewModel.swift
//  KinoCircle
//
//  Created by Jan Madera on 27/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation

class MovieDetailViewModel: ObservableObject {
    @Published var movie = DetailViewModel(movie: MovieDetail(imdbID: "", Title: "", Year: "", Rated: "", Released: "", Runtime: "", Genre: "", Director: "", Writer: "", Actors: "", Plot: "", Language: "", Country: "", Award: "", Ratings: [], Metascore: "", imdbRating: "", imdbVotes: "", DVD: "", BoxOffice: "", Production: "", Website: "", Type: "", Poster: "", Error: "", Response: ""))
    @Published var error: String? = nil
    
    func loadMovie(imdbID: String) {
        MainWebservice().getMovie(imdbID: imdbID) { response in
            
            if let movie = response {
                self.movie = DetailViewModel.init(movie: movie)
            }
            
            if let error = response?.Error {
                self.error = error
            } else {
                self.error = ""
            }
        }
    }
}

struct DetailViewModel {
    var movie: MovieDetail
    
    init(movie: MovieDetail) {
        self.movie = movie
    }
    
    var imdbID: String {
        return self.movie.imdbID!
    }
    
    var title: String {
        return self.movie.Title!
    }
    
    var year: String {
        return self.movie.Year!
    }
    
    var type: String {
        return self.movie.Type!
    }
    
    var poster: String {
        return self.movie.Poster ?? ""
    }
    
    var rated: String {
        return self.movie.Rated ?? ""
    }
    
    var runtime: String {
        return self.movie.Runtime ?? ""
    }
    
    var genre: String {
        return self.movie.Genre ?? ""
    }
    
    var director: String {
        return self.movie.Director ?? ""
    }
    
    var writer: String {
        return self.movie.Writer ?? ""
    }
    
    var actors: String {
        return self.movie.Actors ?? ""
    }
    
    var plot: String {
        return self.movie.Plot ?? ""
    }
    
    var language: String {
        return self.movie.Language ?? ""
    }
    
    var country: String {
        return self.movie.Country ?? ""
    }
    
    var award: String {
        return self.movie.Award ?? "No award"
    }
    
    var ratings: [Rating] {
        return self.movie.Ratings ?? []
    }
    
    var metascore: String {
        return self.movie.Metascore ?? ""
    }
    
    var imdbRating: String {
        return self.movie.imdbRating ?? ""
    }
    
    var imdbVotes: String {
        return self.movie.imdbVotes ?? ""
    }
    
    var DVD: String {
        return self.movie.DVD ?? ""
    }
    
    var boxOffice: String {
        return self.movie.BoxOffice ?? ""
    }
    
    var production: String {
        return self.movie.Production ?? ""
    }
    
    var website: String {
        return self.movie.Website ?? ""
    }
    
}
