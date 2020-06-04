//
//  MoviesShowsShowsView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

struct MoviesShowsShowsView: View {
    @State var searchText = ""
    var searchedTag = "series"
    @ObservedObject private var movieListVM = MovieListViewModel()
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(0.0)
            Button(action: { self.movieListVM.loadMovies(paramTitle: self.searchText, tag: self.searchedTag) }) {
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

struct MoviesShowsShowsView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesShowsShowsView()
    }
}
