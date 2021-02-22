//
//  FooterView.swift
//  MediumAppStickyFooter
//
//  Created by Ginger on 22/02/2021.
//

import SwiftUI

struct FooterView: View {
    // Dark Mode
    @State var darkMode = false
    @State var offset: CGFloat = 0
    
    // For Smaller iPhones
    var isSmaller = UIScreen.main.bounds.height < 750

    var body: some View {
        HStack {
            Button(action: {}) {
                Image(systemName: "hands.clap.fill")
                    .font(.title2)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            
            Group {
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                // Reducing distance while Scrolling
                .offset(x: offset == 0 ? 0 : 50 * (offset / 120))
                
                Button(action: {}) {
                    Image(systemName: "bookmark")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                
                Button(action: {
                    withAnimation {
                        darkMode.toggle()
                    }
                }) {
                    Image(systemName: darkMode ? "sun.min.fill" : "moon")
                        .font(.title2)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
                // Hiding When Goes Away
                .opacity(offset == 0 ? 1 : Double(1 - (offset / 60)))
            }
            .offset(x: offset)
        }
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 15)
        .padding(.top, isSmaller ? 0 : 15)
        // MaxHeight
        .frame(height: isSmaller ? 65 : 80)
        .background(darkMode ? Color.black : Color.white)
        .preferredColorScheme(darkMode ? .dark : .light)
        .overlay(
            // GeometryReader for getting MaxY and Animations
            GeometryReader { proxy -> Color in
                
                let maxY = proxy.frame(in: .global).maxY
                
                let maxHeight = UIScreen.main.bounds.height
                
                DispatchQueue.main.async {
                    if maxY < maxHeight {
                        if offset <= 120 {
                            // Smoothly moving the Offset to 120
                            
                            // Upto -100 Top Scroll
                            // it's your wish to animate
                            let progress = (maxHeight - maxY) / 100
                            
                            self.offset = progress * 120 <= 120 ? progress * 120 : 120
                        }
                    } else {
                        if offset != 0 {
                            // If Scrolled too fast
                            self.offset = 0
                        }
                    }
                }
                
                return Color.clear
            }, alignment: .bottom
        )
        .shadow(color: Color.primary.opacity(offset == 0 ? 0.06 : 0), radius: 5, x: 0, y: -5)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
