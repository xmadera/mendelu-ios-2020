//
//  EditReviewView.swift
//  KinoCircle
//
//  Created by Jan Madera on 07/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

struct EditReviewView: View {
    @Binding var showingEditReview: Bool
    @State var text1: String = ""
    @State var text2: String = ""
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading) {
                Text("Rating")
                TextField("5", text: $text1)
                    .font(Font.system(size: 12, weight: .regular))
                    .frame(width: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Text("Review")
                TextField("Write your review", text: $text2)
                    .font(Font.system(size: 12, weight: .regular))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Spacer()
                
            }.padding()
                .navigationBarTitle(Text("Add review"), displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        // self.close = true
                    }) {
                        Text("Cancel")
                    }, trailing:
                    Button(action: {
                        // self.save = true
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
