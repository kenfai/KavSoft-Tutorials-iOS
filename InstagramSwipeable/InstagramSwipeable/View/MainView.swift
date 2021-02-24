//
//  MainView.swift
//  InstagramSwipeable
//
//  Created by Ginger on 24/02/2021.
//

import SwiftUI

struct MainView: View {
    @State var offset: CGFloat = rect.width
    
    var body: some View {
        // Scrollable Tabs
        GeometryReader { reader in
            
            let frame = reader.frame(in: .global)
            // Since there are three Views
            
            ScrollableTabBar(tabs: ["", "", ""], rect: frame, offset: $offset) {
                PostView(offset: $offset)
                
                Home(offset: $offset)
                
                DirectView(offset: $offset)
            }
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
