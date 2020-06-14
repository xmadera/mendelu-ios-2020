//
//  MoviesDetailView.swift
//  KinoCircle
//
//  Created by Jan Madera on 10/05/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI
import URLImage


struct MoviesDetailCDView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var movieId: String
    @State private var showingActionSheet = false
    @State private var showingEditReview = false
    @ObservedObject private var favoritesListVM = FavoritesListViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    GeometryReader { geometry in
                        if self.favoritesListVM.movie != nil {
                            URLImage((self.favoritesListVM.movie!.poster!.getImageUrl)! , delay: 0.25, content:  {
                                $0.image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: geometry.size.width, height: geometry.size.height / 3)
                            })
                        }
                        
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
                            Text(self.favoritesListVM.movie?.genre ?? "")
                                .foregroundColor(.blue)
                                .font(.system(size: 12, weight: .bold))
                                .padding(.bottom)
                            
                            Text("Director: \(self.favoritesListVM.movie?.director ?? "")")
                                .font(.system(size: 14, weight: .bold))
                                .padding(.bottom)
                            
                            Text(self.favoritesListVM.movie?.plot ?? "")
                                .foregroundColor(.gray)
                                .font(.caption)
                        }.padding(.horizontal)
                            .padding(.top)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text("Actors:")
                                .font(.system(size: 14, weight: .regular))
                                .padding(.bottom)
                            
                            Text(self.favoritesListVM.movie?.actors ?? "")
                                .font(.system(size: 12, weight: .regular))
                                .foregroundColor(.gray)
                        }.padding(.horizontal)
                        
                        Divider()
                        
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
                                    .sheet(isPresented: $showingEditReview, content: { EditReviewView(showingEditReview: self.$showingEditReview) })
                            }.padding(.bottom)
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
        .navigationBarTitle(Text(self.favoritesListVM.movie?.title ?? ""), displayMode: .large)
        .navigationBarItems(trailing:
            
            Button(action: {
                self.showingActionSheet = true;
            }) {
                Image(systemName: "heart.fill").font(.system(size: 24))
                    .foregroundColor(.white)
            } .alert(isPresented: $showingActionSheet) {
                Alert(title: Text("Are you sure you want to remove this from your favorites?"), message: Text("Your review will be lost"), primaryButton: .destructive(Text("Remove")) {
                    MovieCD.delete(context: self.viewContext, movie: (self.favoritesListVM.movie!) as MovieCD)
                    }, secondaryButton: .cancel())}
        )
            .onAppear{
                self.favoritesListVM.loadMovie(id: self.movieId)
        }
    }
    
    func isInCoreData(id: String) -> Bool {
        if self.favoritesListVM.movies.contains(where: { $0.imdbID == id }) { return true } else { return false }
    }
}

//struct MoviesDetailCDView_Previews: PreviewProvider {
//    static var previews: some View {
//        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
//    }
//}
