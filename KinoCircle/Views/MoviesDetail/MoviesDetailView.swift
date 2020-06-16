//
//  MoviesDetailView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage

struct MoviesDetailView: View {
    @State var movieId: String
    @ObservedObject private var movieDetailVM = MovieDetailViewModel()
    
    var body: some View {
        Group {
            if self.movieDetailVM.movie.imdbID == self.movieId {
                MovieDetailUI(ActiveAlert: .notInCore, imdbID: self.movieDetailVM.movie.imdbID, title: self.movieDetailVM.movie.title, poster: self.movieDetailVM.movie.poster, genre: self.movieDetailVM.movie.genre, plot: self.movieDetailVM.movie.plot, actors: self.movieDetailVM.movie.actors, director: self.movieDetailVM.movie.director, type: self.movieDetailVM.movie.type, year: self.movieDetailVM.movie.year, review: "", ratings: self.movieDetailVM.movie.ratings)
            } else {
                Text("Loading..")
                    .font(.title)
                    .foregroundColor(Color("textBlueBackground"))
                    .multilineTextAlignment(.center)
            }
        } .onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.movieDetailVM.loadMovie(imdbID: self.movieId) }
        }
    }
}


//struct MoviesDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
