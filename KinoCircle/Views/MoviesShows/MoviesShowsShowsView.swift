//
//  MoviesShowsShowsView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage

struct MoviesShowsShowsView: View {
    @State var searchText = ""
    var searchedTag = "series"
    @ObservedObject private var movieListVM = MovieListViewModel()
    @ObservedObject private var favoritesListVM = FavoritesListViewModel()
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(0.0)
            Button(action: {
                self.movieListVM.loadMovies(paramTitle: self.searchText, tag: self.searchedTag)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (self.movieListVM.error) != nil {
                        self.showingAlert = true
                    }
                }
            }) {
                Text("Search")
            }
            .disabled(self.searchText.isEmpty)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(self.movieListVM.getError() ?? "Unknown error"), message: Text("Try specifying your seach"), dismissButton: .default(Text("Close")))
            }
            VStack {
                List {
                    ForEach(self.movieListVM.movies, id: \.imdbID) { movie in
                        MovieRow(movie: movie)
                    }
                }
            }
        } .onAppear() { self.favoritesListVM.loadMovies(tag: "series") }
    }
}

struct MoviesShowsShowsView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesShowsShowsView()
    }
}
