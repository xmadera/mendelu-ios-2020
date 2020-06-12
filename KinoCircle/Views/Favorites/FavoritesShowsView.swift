//
//  FavoritesShowsView.swift
//  KinoCircle
//
//  Created by Jan Madera on 04/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage

struct FavoritesShowsView: View {
    @ObservedObject private var FavoritesList = FavoritesListViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(self.FavoritesList.movies, id: \.imdbID) { movie in
                    HStack(alignment: .top) {
                        MovieCDRow(movie: movie.movie)
                    }
                } .onDelete(perform: delete(at:))
            }
        } .onAppear() { self.FavoritesList.loadMovies(tag: "series") }
    }
    func delete(at offsets: IndexSet) {
        self.FavoritesList.movies.remove(atOffsets: offsets)
    }
}

//struct FavoritesShowsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesShowsView()
//    }
//}
