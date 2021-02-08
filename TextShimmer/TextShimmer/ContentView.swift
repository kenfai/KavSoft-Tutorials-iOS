//
//  ContentView.swift
//  TextShimmer
//
//  Created by Ginger on 08/02/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    // Toggle for MultiColors
    @State var multiColors = false
    
    var body: some View {
        VStack(spacing: 25) {
            TextShimmer(text: "Welcome", multiColors: $multiColors)
            TextShimmer(text: "Back", multiColors: $multiColors)
            TextShimmer(text: "Kavsoft", multiColors: $multiColors)
            
            Toggle(isOn: $multiColors, label: {
                Text("Enable Multi Colors")
                    .font(.title)
                    .fontWeight(.bold)
            })
            .padding()
        }
        .preferredColorScheme(.dark)
    }
}

struct TextShimmer: View {
    
    var text: String
    @State var animation = false
    @Binding var multiColors: Bool
    
    var body: some View {
        
        ZStack {
            Text(text)
                .font(.system(size: 75, weight: .bold))
                .foregroundColor(Color.white.opacity(0.25))
            
            // Multicolor Text
            HStack(spacing: 0) {
                ForEach(0..<text.count, id: \.self) { index in
                    Text(String(text[text.index(text.startIndex, offsetBy: index)]))
                        .font(.system(size: 75, weight: .bold))
                        .foregroundColor(multiColors ? randomColor() : Color.white)
                }
            }
            // Masking for Shimmer Effect
                .mask(
                    Rectangle()
                        // For Some more nice effects, we will use Gradient
                        .fill(
                            // You can use any Color here
                            LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0.5), Color.white, Color.white.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                        )
                        .rotationEffect(Angle(degrees: 70))
                        .padding(20)
                    // Moving View continuosly so it will create Shimmer Effect
                        .offset(x: -250)
                        .offset(x: animation ? 500 : 0)
                )
            .onAppear(perform: {
                withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                    animation.toggle()
                }
            })
        }
    }
    
    // Random Color
    
    // It's your wish to change any color
    // or you can also use Array of Colors to pick random One
    func randomColor() -> Color {
        
        let color = UIColor(red: 1, green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1)
        
        return Color(color)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
