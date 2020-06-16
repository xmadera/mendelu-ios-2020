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
    @Environment(\.managedObjectContext) var viewContext
    @State var searchedTag = "series"
    
    var body: some View {
        VStack {
            List {
                ForEach(self.FavoritesList.movies, id: \.imdbID) { movie in
                    HStack(alignment: .top) {
                        MovieRowUI(title: movie.title, poster: movie.poster, year: movie.year, imdbID: movie.imdbID, tag: movie.type)
                    }
                }
            }
        } .onAppear() { self.FavoritesList.loadMovies(tag: self.searchedTag) }
    }
}

//struct FavoritesShowsView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesShowsView()
//    }
//}
