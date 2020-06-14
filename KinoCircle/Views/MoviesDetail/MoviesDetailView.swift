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
        ZStack {
            VStack {
                ZStack {
                    GeometryReader { geometry in
                        URLImage((self.movieDetailVM.movie.poster.getImageUrl)!, delay: 0.25, content:  {
                            $0.image
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: geometry.size.height / 3)
                        })
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom))
                            .cornerRadius(0)
                            .frame(width: geometry.size.width, height: geometry.size.height / 3)
                    }
                }
                Spacer()
            }
            Spacer()
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(self.movieDetailVM.movie.genre)
                                .foregroundColor(.blue)
                                .font(.system(size: 12, weight: .bold))
                                .padding(.bottom)
                            
                            Text("Director: \(self.movieDetailVM.movie.director)")
                                .font(.system(size: 14, weight: .bold))
                                .padding(.bottom)
                            
                            Text(self.movieDetailVM.movie.plot)
                                .foregroundColor(.gray)
                                .font(.caption)
                        }.padding(.horizontal)
                            .padding(.top)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Actors:")
                                .font(.system(size: 14, weight: .regular))
                                .padding(.bottom)
                            
                            Text(self.movieDetailVM.movie.actors)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.gray)
                        }.padding(.horizontal)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("My review:")
                                .font(.system(size: 14, weight: .regular))
                                .padding(.bottom)
                            Text("The best movie I'v ever seen")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.gray)
                                .padding(.bottom)
                        }.padding(.horizontal)
                        
                        VStack(alignment: .leading) {
                            Text("Ratings:")
                                .font(.system(size: 14, weight: .regular))
                                .padding(.bottom)
                            HStack {
                                VStack {
                                    Text("Metascore")
                                    Text("69")
                                }.foregroundColor(.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(8)
                                    .background(Color("textBlueBackground"))
                                    .padding(.trailing, 8)
                                VStack {
                                    Text("IMDb")
                                    Text("8.0")
                                }.foregroundColor(.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(8)
                                    .background(Color("textBlueBackground"))
                                    .padding(.trailing, 8)
                                VStack {
                                    Text("My rating")
                                    Text("9.0")
                                }.foregroundColor(.white)
                                    .font(.system(size: 12, weight: .regular))
                                    .padding(8)
                                    .background(Color("textBlueBackground"))
                                    .padding(.trailing, 8)
                            }
                        }.padding(.horizontal)
                        
                        
                        Spacer()
                    }.background(Color.white)
                        .cornerRadius(20)
                        .frame(height: 450)
                        .shadow(color: Color.black, radius: 10, x: 0, y: 0)
                    
                }
            }.edgesIgnoringSafeArea(.bottom)
            
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitle(Text(self.movieDetailVM.movie.title), displayMode: .large)
        .navigationBarItems(trailing: Button(action: {
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
        })
            .onAppear{
                self.movieDetailVM.loadMovie(imdbID: self.movieId)
        }
    }
    func isInCoreData(id: String) -> Bool {
        if self.favoritesListVM.movies.contains(where: { $0.imdbID == id }) { return true } else { return false }
    }
}

