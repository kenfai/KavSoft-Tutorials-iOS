//
//  Home.swift
//  NavigationSearchBar
//
//  Created by Ginger on 01/02/2021.
//

import SwiftUI

struct Home: View {
    // for search bar
    @Binding var filteredItems: [AppItem]
    
    var body: some View {
        // App List view
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                // Apps List
                ForEach(filteredItems) { item in
                    // Card View
                    CardView(item: item)
                }
            }
            .padding()
        }
    }
}
