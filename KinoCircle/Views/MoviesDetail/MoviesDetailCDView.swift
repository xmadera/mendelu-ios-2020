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
    @State var movie: MovieCD
    @State private var showingActionSheet = false
    @ObservedObject private var movieDetailVM = MovieDetailViewModel()
    
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                ZStack{
                    URLImage(self.movie.poster?.getImageUrl ?? URL(string: "")!, delay: 0.25, content:  {
                        $0.image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                    })
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(0)
                        .frame(height: 250)
                    
                    
                    Text(self.movieDetailVM.movie.plot)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .navigationBarItems(trailing:
                            Button(action: {
                                self.showingActionSheet = true
                            }) {
                                Image(systemName: "list.bullet")
                            }
                    )
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
                        .shadow(color: .gray, radius: 8)
                        .offset(y: 278)
                }
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
                .actionSheet(isPresented: self.$showingActionSheet) {
                    ActionSheet(title: Text("Options"), buttons: [.default(Text("Remove from favorites"), action: { }), .cancel()])
            }
        .onAppear{
            self.movieDetailVM.loadMovie(imdbID: self.movie.imdbID ?? "")
            }
            
            
            
            
        }.navigationBarTitle(Text(self.movieDetailVM.movie.title).foregroundColor(.white), displayMode: .large)
            .edgesIgnoringSafeArea(.top)
        
    }
}

struct MoviesDetailCDView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
