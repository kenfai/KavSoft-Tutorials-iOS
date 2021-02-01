//
//  CustomNavigationView.swift
//  NavigationSearchBar
//
//  Created by Ginger on 01/02/2021.
//

import SwiftUI

struct CustomNavigationView: UIViewControllerRepresentable {
    
    // Just Change your view that requires Search Bar
    var view: AnyView
    
    // Ease of Use
    var largeTitle: Bool
    var title: String
    var placeHolder: String
    
    // onSearch and onCancel closures
    var onSearch: (String) -> ()
    var onCancel: () -> ()
    
    // required Closure on Call
    init(view: AnyView, placeHolder: String? = "Search", largeTitle: Bool? = true, title: String, onSearch: @escaping (String) -> (), onCancel: @escaping () -> ()) {
        
        self.title = title
        self.largeTitle = largeTitle!
        self.placeHolder = placeHolder!
        self.view = view
        self.onSearch = onSearch
        self.onCancel = onCancel
    }
    
    func makeCoordinator() -> Coordinator {
        return CustomNavigationView.Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> UINavigationController {
        
        // requires SwiftUI View
        let childView = UIHostingController(rootView: view)
        
        let controller = UINavigationController(rootViewController: childView)
        
        // Nav Bar Data
        controller.navigationBar.topItem?.title = title
        controller.navigationBar.prefersLargeTitles = largeTitle
        
        // SearchBar
        let searchController = UISearchController()
        searchController.searchBar.placeholder = placeHolder
        
        // setting delegate
        searchController.searchBar.delegate = context.coordinator
        
        // setting SearchBar in NavBar
        // disabling hide on Scroll
        
        // disabling dim bg
        searchController.obscuresBackgroundDuringPresentation = false
        
        controller.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
        controller.navigationBar.topItem?.searchController = searchController
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Updating Real Time
        uiViewController.navigationBar.topItem?.title = title
        uiViewController.navigationBar.topItem?.searchController?.searchBar.placeholder = placeHolder
        uiViewController.navigationBar.prefersLargeTitles = largeTitle
    }
    
    // SearchBar Delegate
    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: CustomNavigationView
        
        init(parent: CustomNavigationView) {
            self.parent = parent
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // when text changes
            self.parent.onSearch(searchText)
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            // when cancel button is clicked
            self.parent.onCancel()
        }
    }
}
