//
//  FavoritesMoviesView.swift
//  KinoCircle
//
//  Created by Jan Madera on 04/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage

struct FavoritesMoviesView: View {
    @Environment(\.managedObjectContext)
    var viewContext
    @ObservedObject private var FavoritesList = FavoritesListViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(self.FavoritesList.movies, id: \.imdbID) { movie in
                    HStack(alignment: .top) {
                        MovieCDRow(movie: movie.movie)
                    }
                }
            }
        }
    }
}

//struct FavoritesMoviesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesMoviesView()
//    }
//}
