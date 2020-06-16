//
//  FavoritesListViewModel.swift
//  KinoCircle
//
//  Created by Jan Madera on 16/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import Foundation

class FavoritesListViewModel: ObservableObject {
    @Published var movies = [MovieCDViewModel]()
    @Published var movie: MovieCD? = nil
    
    func loadMovies(tag: String) {
        self.movies = CoreDataManager.shared.getMovies(tag: tag).map(MovieCDViewModel.init)
    }
}
