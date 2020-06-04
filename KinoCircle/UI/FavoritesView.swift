//
//  FavoritesView.swift
//  KinoCircle
//
//  Created by Jan Madera on 21/04/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage

struct FavoritesView: View {
    @State private var selectorIndex = 0
    @State private var tabs = ["Movies","Shows"]
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MovieCD.title, ascending: true)],
        animation: .default)
    var movies: FetchedResults<MovieCD>
    
    @Environment(\.managedObjectContext)
    var viewContext
    
    var body: some View {
                    VStack {
            List {
                ForEach(self.movies, id: \.imdbID) { movie in
                        HStack(alignment: .top) {
                            URLImage(self.returnImageURL(poster: movie.poster!), delay: 0.25, content:  {
                                $0.image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                            })
                            VStack(alignment: .leading) {
                                Text(movie.title!).font(.headline).padding(.bottom, 4)
                                Text(movie.year!).font(.subheadline)
                            }
                        }.frame(height: 100)
                }
            }
        }
    }
    func returnImageURL(poster: String) -> URL {
        return URL(string: poster)!
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
