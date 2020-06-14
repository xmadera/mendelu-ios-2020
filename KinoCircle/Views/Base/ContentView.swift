//
//  ContentView.swift
//  KinoCircle
//
//  Created by Jan Madera on 21/04/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

enum TabBar {
    case movies_and_shows
    case favourites
    
    var tabBarTitle: String {
        switch self {
        case .movies_and_shows:
            return "Movies & Shows"
        case .favourites:
            return "Favorites"
        }
    }
}

struct ContentView: View {
    @State private var selected = TabBar.movies_and_shows
    
    var body: some View {
        NavigationView {
            TabView(selection: $selected) {
                MoviesShowsView()
                    .tabItem({
                        selected == TabBar.movies_and_shows ? Image(systemName: "film.fill") : Image(systemName: "film")
                        Text(TabBar.movies_and_shows.tabBarTitle)
                    }).tag(TabBar.movies_and_shows)
                FavoritesView()
                    .tabItem({
                        selected == TabBar.favourites ? Image(systemName: "star.fill") : Image(systemName: "star")
                        Text(TabBar.favourites.tabBarTitle)
                    }).tag(TabBar.favourites)
            }
            .navigationBarTitle(Text(selected.tabBarTitle), displayMode: .inline)
            .accentColor(Color.blue)
        }
        
    }
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
        .foregroundColor: UIColor.white,
        .font : UIFont(name:"Optima-Bold", size: 20)!]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
