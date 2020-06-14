//
//  EditReviewView.swift
//  KinoCircle
//
//  Created by Jan Madera on 07/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

struct EditReviewView: View {
    @ObservedObject private var favoritesListVM = FavoritesListViewModel()
    @Binding var showingEditReview: Bool
    @Binding var review: String
    @State var movieId: String
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Text("Review")
                TextField("Write your review", text: $review)
                    .font(Font.system(size: 12, weight: .regular))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
            }.padding()
                .navigationBarTitle(Text("Add review"), displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.showingEditReview = false
                    }) {
                        Text("Cancel")
                    }, trailing:
                    Button(action: {
                        self.favoritesListVM.updateMovie(id: self.movieId, text: self.review)
                        self.showingEditReview = false
                    }) {
                        Text("Save")
                    }
            )
        }
    }
}

//struct EditReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        editReviewView()
//    }
//}
