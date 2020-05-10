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
    
    func loadMovies(paramTitle: String) {
        Webservice().getMovies(paramsTitle: paramTitle) { movies in
            
            if let movies = movies {
                self.movies = movies.map(MovieViewModel.init)
            }
        }
    }
}
