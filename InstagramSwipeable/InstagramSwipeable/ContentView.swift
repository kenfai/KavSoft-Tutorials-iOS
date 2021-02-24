//
//  ContentView.swift
//  InstagramSwipeable
//
//  Created by Ginger on 24/02/2021.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        MainView()
    }
}

// Global Usage Values
var rect = UIScreen.main.bounds
var edges = UIApplication.shared.windows.first?.safeAreaInsets

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
