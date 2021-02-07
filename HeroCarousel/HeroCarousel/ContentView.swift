//
//  ContentView.swift
//  HeroCarousel
//
//  Created by Ginger on 07/02/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeModel = CarouselViewModel()

    var body: some View {
        Home()
            .environmentObject(homeModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
