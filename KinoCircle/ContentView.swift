//
//  ContentView.swift
//  KinoCircle
//
//  Created by Jan Madera on 21/04/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selected = "Movies & Shows"

    var body: some View {
        NavigationView {
            TabView(selection: $selected) {
                MoviesShowsView()
                .tabItem({
                        selected == "Movies & Shows" ? Image(systemName: "film.fill") : Image(systemName: "film")
                        Text("Movies & Shows")
                }).tag("Movies & Shows")
                    FavoritesView()
                    .tabItem({
                        selected == "Favorites" ? Image(systemName: "star.fill") : Image(systemName: "star")
                        Text("Favorites")
                }).tag("Favorites")
            }.navigationBarTitle(Text(self.selected), displayMode: .inline)
             .accentColor(Color.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
