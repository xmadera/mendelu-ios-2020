//
//  MovieCDRow.swift
//  KinoCircle
//
//  Created by Jan Madera on 05/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import URLImage
import SwiftUI
struct MovieCDRow : View {
    var movie: MovieCD
    
    var body: some View {
        NavigationLink(destination: MoviesDetailCDView(movie: movie)) {
            HStack(alignment: .top) {
                URLImage(movie.poster!.getImageUrl, delay: 0.25, content:  {
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

