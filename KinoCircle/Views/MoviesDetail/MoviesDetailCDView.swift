//
//  MoviesDetailView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage

struct MoviesDetailCDView: View {
    @State var movieId: String
    @ObservedObject private var favoritesListVM = FavoritesListViewModel()
    
    var body: some View {
        Group {
            if self.favoritesListVM.movie?.imdbID == self.movieId {
                MovieDetailUI(ActiveAlert: .inCore, imdbID: self.favoritesListVM.movie?.imdbID ?? "", title: self.favoritesListVM.movie?.title ?? "", poster: self.favoritesListVM.movie?.poster ?? "", genre: self.favoritesListVM.movie?.genre ?? "", plot: self.favoritesListVM.movie?.plot ?? "", actors: self.favoritesListVM.movie?.actors ?? "", director: self.favoritesListVM.movie?.director ?? "", type: self.favoritesListVM.movie?.type ?? "", year: self.favoritesListVM.movie?.year ?? "", review: self.favoritesListVM.movie?.review ?? "")
            } else {
                Text("Loading..")
                    .font(.title)
                    .foregroundColor(Color("textBlueBackground"))
                    .multilineTextAlignment(.center)
            }
        }.onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.favoritesListVM.loadMovie(id: self.movieId)
            }
        }
    }
}

//struct MoviesDetailCDView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
