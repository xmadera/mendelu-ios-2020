//
//  SearchBarView.swift
//  KinoCircle
//
//  Created by Jan Madera on 04/06/2020.
//  Copyright © 2020 Jan Madera. All rights reserved.
//

import SwiftUI

struct SearchBarUI: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText.folding(options: .diacriticInsensitive, locale: .current)
        }
    }
    
    func makeCoordinator() -> SearchBarUI.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBarUI>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        searchBar.placeholder = "Search"
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBarUI>) {
        uiView.text = text
    }
}
