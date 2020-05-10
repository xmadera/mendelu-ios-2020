//
//  MoviesShowsMoviesView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

struct MoviesShowsMoviesView: View {
    @State var searchText = ""
    @ObservedObject private var movieListVM = MovieListViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
            .padding(0.0)
            Button(action: { self.movieListVM.loadMovies(paramTitle: self.searchText) }) {
                Text("Search")
            }
            List(self.movieListVM.movies, id: \.imdbID) { movie in
                NavigationLink(destination: MoviesShowsDetailView(movie: movie)) {
                    Text(movie.title)
                }
            }
        }
    }
}

struct MoviesShowsMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesShowsMoviesView()
    }
}
