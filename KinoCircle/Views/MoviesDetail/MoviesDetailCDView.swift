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
    @ObservedObject private var favoritesDetailVM = FavoritesDetailViewModel()
    
    var body: some View {
        Group {
            if self.favoritesDetailVM.movie?.imdbID == self.movieId {
                MovieDetailUI(ActiveAlert: .inCore, imdbID: self.favoritesDetailVM.movie?.imdbID ?? "", title: self.favoritesDetailVM.movie?.title ?? "", poster: self.favoritesDetailVM.movie?.poster ?? "", genre: self.favoritesDetailVM.movie?.genre ?? "", plot: self.favoritesDetailVM.movie?.plot ?? "", actors: self.favoritesDetailVM.movie?.actors ?? "", director: self.favoritesDetailVM.movie?.director ?? "", type: self.favoritesDetailVM.movie?.type ?? "", year: self.favoritesDetailVM.movie?.year ?? "", review: self.favoritesDetailVM.movie?.review ?? "", ratings: [])
            } else {
                Text("Loading..")
                    .font(.title)
                    .foregroundColor(Color("textBlueBackground"))
                    .multilineTextAlignment(.center)
            }
        }.onAppear{ DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.favoritesDetailVM.loadMovie(id: self.movieId)
            }
        }
    }
}

//struct MoviesDetailCDView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
