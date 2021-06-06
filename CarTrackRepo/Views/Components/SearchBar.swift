//
//  SearchBar.swift
//  CarTrackPiraba
//
//  Created by Piraba Nagkeeran on 5/6/21.
//

import UIKit
import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.barStyle = .black
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.barTintColor = UIColor(named: "Background")
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = self.text
    }

    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: self.$text)
    }
}

extension SearchBar {
    final class Coordinator: NSObject, UISearchBarDelegate {
        let text: Binding<String>

        init(text: Binding<String>) {
            self.text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.text.wrappedValue = searchText
        }

        func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.setShowsCancelButton(true, animated: true)
            return true
        }

        func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
            searchBar.setShowsCancelButton(false, animated: true)
            return true
        }

        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.endEditing(true)
            searchBar.text = ""
            self.text.wrappedValue = ""
        }
    }
}
