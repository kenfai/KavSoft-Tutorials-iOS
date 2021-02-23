//
//  Home.swift
//  ScrollableTabBar
//
//  Created by Ginger on 23/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    @State var offset: CGFloat = 0
    @State var showCapsule = false
    
    var body: some View {
        GeometryReader { proxy in
            
            let rect = proxy.frame(in: .global)
            
            ScrollableTabBar(tabs: tabs, rect: rect, offset: $offset) {
                HStack(spacing: 0) {
                    ForEach(image_URLs.indices, id: \.self) { index in
                        WebImage(url: URL(string: image_URLs[index]))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: rect.width)
                            // Bug fix
                            .cornerRadius(0)
                            .overlay(Color.black.opacity(0.3))
                    }
                }
                .ignoresSafeArea()
            }
        }
        .ignoresSafeArea()
        .overlay(
            // Tab Bar
            TabBar(offset: $offset, showCapsule: $showCapsule)
            , alignment: .top
        )
        .overlay(
            // Enlarge Capsule Button
            Button(action: {
                withAnimation {
                    showCapsule.toggle()
                }
            }) {
                Image(systemName: "fiberchannel")
                    .font(.title2)
                    .padding()
                    .background(Color("lightblue"))
                    .foregroundColor(.black)
                    .clipShape(Circle())
            }
            .padding()
            
            , alignment: .bottomTrailing
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

var tabs = ["Home", "Search", "Account"]
