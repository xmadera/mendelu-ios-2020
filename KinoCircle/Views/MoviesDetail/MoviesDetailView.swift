//
//  MoviesDetailView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage


struct MoviesDetailView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var movieId: String
    @State private var showingActionSheet = false
    @ObservedObject private var movieDetailVM = MovieDetailViewModel()
    @ObservedObject private var favoritesListVM = FavoritesListViewModel()
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                ZStack{
                    URLImage((self.movieDetailVM.movie.poster.getImageUrl)!, delay: 0.25, content:  {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 200)
                    })
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(0)
                        .frame(height: 200)
                    
                    
                    Text(self.movieDetailVM.movie.plot)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(Color("textDarkBackground"))
                        .cornerRadius(5)
                        .offset(y: 170)
                    
                    Text(self.movieDetailVM.movie.genre)
                        .foregroundColor(.white)
                        .font(.system(size: 12, weight: .regular))
                        .padding()
                        .background(Color("textBlueBackground"))
                        .frame(height: 40)
                        .cornerRadius(20)
                        .offset(y: 278)
                    
                    HStack {
                        Text(self.movieDetailVM.movie.title)
                            .foregroundColor(.white)
                            .font(.system(size: 24, weight: .regular))
                        
                        Spacer()
                        Button(action: {
                            if !self.isInCoreData(id: self.movieDetailVM.movie.imdbID) {
                                self.showingActionSheet = true;
                            }
                        }) {
                            if !isInCoreData(id: self.movieDetailVM.movie.imdbID) {
                                Image(systemName: "heart").font(.system(size: 24))
                                    .foregroundColor(.white)
                            } else {
                                Image(systemName: "heart.fill").font(.system(size: 24))
                                    .foregroundColor(.white)
                            }
                            
                        }.alert(isPresented: $showingActionSheet) {
                            Alert(title: Text("Are you sure you want to add this from your favorites?"), primaryButton: .default(Text("Add")) {
                                MovieCD.create(context: self.viewContext, movie: self.movieDetailVM.movie)
                                self.favoritesListVM.loadMovies(tag: self.movieDetailVM.movie.type)
                                }, secondaryButton: .cancel())
                        }
                        
                    }.padding()
                        .padding(.top)
                }.edgesIgnoringSafeArea(.top)
            }
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text("Director: \(self.movieDetailVM.movie.director)")
                    .font(.system(size: 14, weight: .bold))
                    .padding(.bottom)
                
                
                Text("Writers:")
                    .font(.system(size: 14, weight: .regular))
                Text(self.movieDetailVM.movie.writer)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .padding(.vertical)
                
                Text("Actors:")
                    .font(.system(size: 14, weight: .regular))
                Text(self.movieDetailVM.movie.actors)
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .padding(.vertical)
                
                Text("My review:")
                    .font(.system(size: 14, weight: .regular))
                Text("...")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(.gray)
                    .padding(.vertical)
                
                Divider()
                
                Text("Ratings")
                    .padding(.vertical)
                
                //                HStack {
                //                    ForEach(self.movieDetailVM.movie.ratings) { rating in
                //                        VStack {
                //                            Text("\(rating.Source)")
                //                            Text("\(rating.Value)")
                //                        }
                //                    }
                //                }
                
            }.padding()
        }
        .onAppear{
            self.movieDetailVM.loadMovie(imdbID: self.movieId)
        }
    }
    func isInCoreData(id: String) -> Bool {
        if self.favoritesListVM.movies.contains(where: { $0.imdbID == id }) { return true } else { return false }
    }
}

//struct MoviesDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/movieDetailVM
//    }
//}
