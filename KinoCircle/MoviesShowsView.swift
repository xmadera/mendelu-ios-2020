//
//  MoviesShowsView.swift
//  KinoCircle
//
//  Created by Jan Madera on 21/04/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct MoviesShowsView: View {
    @State var searchText = ""
    @State private var selectorIndex = 0
    @State private var tabs = ["Movies","Shows"]
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText)
                .padding(0.0)
            Picker("Numbers", selection: $selectorIndex) {
                ForEach(0 ..< tabs.count) { index in
                    Text(self.tabs[index]).tag(index)
                }
            }
            .padding(.top, -8.0)
            .pickerStyle(SegmentedPickerStyle())
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct MoviesShowsView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesShowsView()
    }
}
