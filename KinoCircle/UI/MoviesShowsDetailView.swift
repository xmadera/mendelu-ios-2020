//
//  MoviesShowsDetailView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

struct MoviesShowsDetailView: View {
    @State var movie: MovieViewModel
    var body: some View {
        Text(movie.title)
    }
}
