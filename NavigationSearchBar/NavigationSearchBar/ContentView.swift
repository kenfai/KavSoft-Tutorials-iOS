//
//  ContentView.swift
//  NavigationSearchBar
//
//  Created by Ginger on 01/02/2021.
//

import SwiftUI

struct ContentView: View {
    @State var filteredItems = apps
    
    var body: some View {
        CustomNavigationView(view: AnyView(Home(filteredItems: $filteredItems)), placeHolder: "Apps, Games", largeTitle: true, title: "KavSoft", onSearch: { txt in
            
            // filtering Data
            if txt != "" {
                self.filteredItems = apps.filter{
                    $0.name.lowercased().contains(txt.lowercased())
                }
            } else {
                self.filteredItems = apps
            }
        }, onCancel: {
            // Do you own code when search and canceled
            self.filteredItems = apps
        })
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
