//
//  Layout2.swift
//  InstagramExploreLayout
//
//  Created by Ginger on 09/02/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct Layout2: View {
    var cards: [Card]
    
    var body: some View {
        HStack(spacing: 4) {
            
            AnimatedImage(url: URL(string: cards[0].download_url))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (width / 3), height: 125)
                .cornerRadius(4)
                .modifier(ContextModifier(card: cards[0]))
            
            if cards.count >= 2 {
                
                AnimatedImage(url: URL(string: cards[1].download_url))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (width / 3), height: 123)
                    .cornerRadius(4)
                    .modifier(ContextModifier(card: cards[1]))
            }
            
            if cards.count == 3 {
                
                AnimatedImage(url: URL(string: cards[2].download_url))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: (width / 3), height: 123)
                    .cornerRadius(4)
                    .modifier(ContextModifier(card: cards[2]))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
