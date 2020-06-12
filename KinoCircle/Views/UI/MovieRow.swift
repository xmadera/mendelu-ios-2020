//
//  MovieRow.swift
//  KinoCircle
//
//  Created by Jan Madera on 05/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import URLImage
import SwiftUI
struct MovieRow : View {
    var movie: MovieViewModel
    
    var body: some View {
        NavigationLink(destination: MoviesDetailView(movieId: movie.imdbID)) {
            HStack(alignment: .top) {
                URLImage(movie.movie.Poster.getImageUrl!, delay: 0.25, content:  {
                    $0.image
                        .resizable()
                        .frame(width: 100, height: 100)
                })
                VStack(alignment: .leading) {
                    Text(movie.movie.Title).font(.headline).padding(.bottom, 4)
                    Text(movie.movie.Year).font(.subheadline)
                }
            }.frame(height: 100)
        }
    }
}
