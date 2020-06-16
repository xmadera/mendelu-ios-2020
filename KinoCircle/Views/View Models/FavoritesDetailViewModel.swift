//
//  FavoritesDetailViewModel.swift
//  KinoCircle
//
//  Created by Jan Madera on 16/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation

class FavoritesDetailViewModel: ObservableObject {
    @Published var movie: MovieCD? = nil
       
    func createMovie(id: String, title: String, type: String, poster: String, year: String, actors: String, director: String, plot: String, genre: String, rating: [Rating]) {
           CoreDataManager.shared.createMovie(imdbID: id, title: title, type: type, poster: poster, year: year, actors: actors, director: director, plot: plot, genre: genre, rating: rating)
       }
       
       func deleteMovie(movie: MovieCD) {
           CoreDataManager.shared.deleteMovie(movie: movie)
       }
       
       func updateMovie(id: String, text: String) {
           CoreDataManager.shared.updateMovie(id: id, text: text)
       }
       
       func loadMovie(id: String) {
           self.movie = CoreDataManager.shared.getMovie(id: id)
       }
}
