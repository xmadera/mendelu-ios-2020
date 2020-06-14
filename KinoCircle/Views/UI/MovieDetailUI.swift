//
//  MovieDetail.swift
//  KinoCircle
//
//  Created by Jan Madera on 14/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import URLImage
import SwiftUI

enum ActiveAlert {
    case inCore, notInCore
}

struct MovieDetailUI: View {
    @ObservedObject private var favoritesListVM = FavoritesListViewModel()
    @State private var showAlert = false
    @State private var showingEditReview = false
    @State var ActiveAlert: ActiveAlert
    @State var imdbID: String
    @State var title: String
    @State var poster: String
    @State var genre: String
    @State var plot: String
    @State var actors: String
    @State var director: String
    @State var type: String
    @State var year: String
    @State var review: String
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    URLImage((self.poster.getImageUrl)!, delay: 0.25, content:  {
                        $0.image
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                    })
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(0)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
                }
                Spacer()
            }
            Spacer()
            VStack {
                Spacer()
                
                HStack {
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text(self.genre)
                                .foregroundColor(.blue)
                                .font(.system(size: 12, weight: .bold))
                                .padding(.bottom)
                            
                            Text("Director: \(self.director)")
                                .font(.system(size: 14, weight: .bold))
                                .padding(.bottom)
                            
                            Text(self.plot)
                                .foregroundColor(.gray)
                                .font(.caption)
                        }.padding(.horizontal)
                            .padding(.top)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Actors:")
                                .font(.system(size: 14, weight: .regular))
                                .padding(.bottom)
                            
                            Text(self.actors)
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.gray)
                        }.padding(.horizontal)
                        
                        Divider()
                        
                        if self.favoritesListVM.isInCoreData(tag: self.type, id: self.imdbID) {
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Text("My review:")
                                        .font(.system(size: 14, weight: .regular))
                                    
                                    Button(action: {
                                        self.showingEditReview = true
                                    }) { Text("edit")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 12, weight: .regular))
                                        .padding(.horizontal, 8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.gray, lineWidth: 1)
                                        )
                                    }.padding(.leading, 4)
                                        .sheet(isPresented: $showingEditReview, onDismiss: {self.favoritesListVM.loadMovie(id: self.imdbID)}, content: { EditReviewView(showingEditReview: self.$showingEditReview, review: self.$review, movieId: self.imdbID) })
                                }.padding(.bottom)
                                Text(self.review)
                                    .font(.system(size: 12, weight: .regular))
                                    .foregroundColor(.gray)
                                    .padding(.bottom)
                            }.padding(.horizontal)
                        }
                        
                        
                        VStack(alignment: .leading) {
                            Text("Ratings:")
                                .font(.system(size: 14, weight: .regular))
                                .padding(.bottom)
                            HStack {
                                VStack {
                                    Text("Metascore")
                                    Text("75")
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
                                //                                VStack {
                                //                                    Text("My rating")
                                //                                    Text("9.0")
                                //                                }.foregroundColor(.white)
                                //                                    .font(.system(size: 12, weight: .regular))
                                //                                    .padding(8)
                                //                                    .background(Color("textBlueBackground"))
                                //                                    .padding(.trailing, 8)
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
        .navigationBarTitle(Text(self.title), displayMode: .large)
        .navigationBarItems(trailing: Button(action: {
            self.showAlert = true
            if !self.favoritesListVM.isInCoreData(tag: self.type, id: self.imdbID) {
                self.ActiveAlert = .notInCore
            } else {
                self.ActiveAlert = .inCore
            }
        }) {
            if self.favoritesListVM.isInCoreData(tag: self.type, id: self.imdbID) {
                Image(systemName: "heart.fill").font(.system(size: 24))
                    .foregroundColor(.red)
            } else {
                Image(systemName: "heart").font(.system(size: 24))
                    .foregroundColor(.red)
            }
            
        }.alert(isPresented: self.$showAlert) {
            switch ActiveAlert {
            case .notInCore:
                return Alert(title: Text("Are you sure you want to add this to your favorites?"), primaryButton: .default(Text("Add")) { self.favoritesListVM.createMovie(id: self.imdbID, title: self.title, type: self.type, poster: self.poster, year: self.year, actors: self.actors, director: self.director, plot: self.plot, genre: self.genre); self.favoritesListVM.loadMovies(tag: self.type) }, secondaryButton: .cancel())
            case .inCore:
                return Alert(title: Text("Are you sure you want to remove this from your favorites?"), message: Text("Your review will be lost"), primaryButton: .destructive(Text("Remove")) { self.favoritesListVM.loadMovie(id: self.imdbID); self.favoritesListVM.deleteMovie(movie: (self.favoritesListVM.movie!) as MovieCD) }, secondaryButton: .cancel())
            }
        })
    }
}


//struct MovieDetailUI_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
