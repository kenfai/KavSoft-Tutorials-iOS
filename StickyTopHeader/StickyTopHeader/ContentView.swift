//
//  ContentView.swift
//  StickyTopHeader
//
//  Created by Ginger on 10/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .preferredColorScheme(.dark)
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
