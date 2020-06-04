//
//  MoviesShowsMoviesView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage

struct MoviesShowsMoviesView: View {
    @State var searchText = ""
    var searchedTag = "movie"
    @ObservedObject private var movieListVM = MovieListViewModel()
    @State private var showingAlert = false
    
    init() {
        UITableView.appearance().showsVerticalScrollIndicator = false
    }
    
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
                        NavigationLink(destination: MoviesDetailView(movie: movie)) {
                            HStack(alignment: .top) {
                                URLImage(movie.poster.getImageUrl, delay: 0.25, content:  {
                                    $0.image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                })
                                VStack(alignment: .leading) {
                                    Text(movie.title).font(.headline).padding(.bottom, 4)
                                    Text(movie.year).font(.subheadline)
                                }
                            }.frame(height: 100)
                        }
                    }
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
