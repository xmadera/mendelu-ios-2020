//
//  MovieRow.swift
//  KinoCircle
//
//  Created by Jan Madera on 05/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import URLImage
import SwiftUI

struct MovieRowUI : View {
    @ObservedObject private var favoritesListVM = FavoritesListViewModel()
    var title: String
    var poster: String
    var year: String
    var imdbID: String
    var tag: String
    
    var body: some View {
        NavigationLink(destination: {
            VStack{
                if !CoreDataManager.shared.isInCoreData(tag: self.tag, id: self.imdbID) {
                    MoviesDetailView(movieId: self.imdbID)
                } else {
                    MoviesDetailCDView(movieId: self.imdbID)
                }
            }
        }()) {
            HStack(alignment: .top) {
                URLImage(poster.getImageUrl!, delay: 0.25, content:  {
                    $0.image
                        .resizable()
                        .frame(width: 100, height: 100)
                })
                VStack(alignment: .leading) {
                    Text(title).font(.headline).padding(.bottom, 4)
                    Text(year).font(.subheadline)
                }
                Spacer()
                if !CoreDataManager.shared.isInCoreData(tag: self.tag, id: self.imdbID) {
                    Image(systemName: "heart")
                        .padding(.top, 8)
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                } else {
                    Image(systemName: "heart.fill")
                        .padding(.top, 8)
                        .font(.system(size: 16))
                        .foregroundColor(.red)
                }
            }.frame(height: 100)
        }
    }
}

struct MovieRow_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
