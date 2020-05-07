//
//  FavoritesView.swift
//  KinoCircle
//
//  Created by Jan Madera on 21/04/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

struct FavoritesView: View {
    @State private var selectorIndex = 0
    @State private var tabs = ["Movies","Shows"]
    
    var body: some View {
        VStack {
            Picker("Numbers", selection: $selectorIndex) {
                ForEach(0 ..< tabs.count) { index in
                    Text(self.tabs[index]).tag(index)
                }
                å}
                .padding(.top)
                .pickerStyle(SegmentedPickerStyle())
            Spacer()
        }.padding(.horizontal)            .navigationBarTitle("Favorites", displayMode: .inline)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
