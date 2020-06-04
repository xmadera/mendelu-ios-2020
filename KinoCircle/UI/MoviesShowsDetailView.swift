//
//  MoviesShowsDetailView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage

struct MoviesShowsDetailView: View {
    
    @Environment(\.managedObjectContext) var viewContext
    @State var movie: MovieViewModel
    @State private var showingActionSheet = false
    @ObservedObject private var movieDetailVM = MovieDetailViewModel()
    
    
    
    var body: some View {
        GeometryReader { metrics in
            VStack {
                VStack {
                    URLImage(self.returnImageURL(), delay: 0.25, content:  {
                        $0.image
                            .resizable()
                            .frame(width: metrics.size.width, height: metrics.size.height / 2, alignment: .top)
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                    })
                        .shadow(color: .black, radius: 5)
                }
                ScrollView {
                    VStack(alignment: .center) {
                        Text(self.movieDetailVM.movie.title)
                            .font(.headline)
                        Text(self.movieDetailVM.movie.plot)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .navigationBarItems(trailing:
                                Button(action: {
                                    self.showingActionSheet = true
                                }) {
                                    Image(systemName: "list.bullet")
                                }
                        )
                            .actionSheet(isPresented: self.$showingActionSheet) {
                                ActionSheet(title: Text("Options"), buttons: [.default(Text("Add to favorites"), action: { MovieCD.create(context: self.viewContext, movie: self.movie) }), .cancel()])
                        }
                    }                .frame(width: metrics.size.width, height: metrics.size.height / 2, alignment: .top)
                    
                }.onAppear{
                    self.movieDetailVM.loadMovie(imdbID: self.movie.imdbID)
                }
            }
        }
    }
    
    func returnImageURL() -> URL {
        return URL(string: self.movie.poster)!
    }
}

struct MoviesShowsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
