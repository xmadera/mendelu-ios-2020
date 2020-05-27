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
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(0.0)
            Button(action: {
                self.movieListVM.loadMovies(paramTitle: self.searchText, tag: self.searchedTag)
            }) {
                Text("Search")
            } .disabled(self.searchText.isEmpty)
            Text(self.error())
                .foregroundColor(Color.red)
                .padding(.vertical)
            GeometryReader { metrics in
                List(self.movieListVM.movies, id: \.imdbID) { movie in
                    NavigationLink(destination: MoviesShowsDetailView(imdbID: movie.imdbID, moviePoster: movie.poster)) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color.white)
                                .shadow(color: .gray, radius: 2)
                                .frame(width: metrics.size.width * 0.9, height: metrics.size.height * 0.3)
                            GeometryReader { metrics in
                                HStack {
                                    VStack(alignment: .leading) {
                                        URLImage(self.returnImageURL(poster: movie.poster), delay: 0.25, content:  {
                                            $0.image
                                                .resizable()
                                                .frame(width: metrics.size.width * 0.3, height: metrics.size.height * 0.6, alignment: .leading)
                                        })
                                    } .frame(width: metrics.size.width * 0.4, height: metrics.size.height)
                                    VStack(alignment: .leading) {
                                        Text(movie.title)
                                        Text(movie.year)
                                    } .frame(width: metrics.size.width * 0.5, height: metrics.size.height)
                                }
                            }
                        }
                    }
                }.frame(width: metrics.size.width, height: metrics.size.height, alignment: .center)
            }        }
    }
    
    func error() -> String {
        if let myError = movieListVM.error {
            return myError
        }
        return ""
    }
    
    func returnImageURL(poster: String) -> URL {
        return URL(string: poster)!
    }
}

struct MoviesShowsMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesShowsMoviesView()
    }
    
}
