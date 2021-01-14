//
//  ContentView.swift
//  ViewBuilder
//
//  Created by Ginger on 14/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .padding(.top)
                .navigationTitle("View Builders")
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
