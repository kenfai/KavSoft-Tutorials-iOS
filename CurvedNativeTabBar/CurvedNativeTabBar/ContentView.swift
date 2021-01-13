//
//  ContentView.swift
//  CurvedNativeTabBar
//
//  Created by Ginger on 13/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var selected = "Home"
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @State var centerX: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $selected) {
                Color.red
                    .tag(tabItems[0])
                    .ignoresSafeArea(.all, edges: .top)
                
                Color.blue
                    .tag(tabItems[1])
                    .ignoresSafeArea(.all, edges: .top)
            
                Color.black
                    .tag(tabItems[2])
                    .ignoresSafeArea(.all, edges: .top)
            
                Color.yellow
                    .tag(tabItems[3])
                    .ignoresSafeArea(.all, edges: .top)
            }
            
            // Custom TabBar
            HStack(spacing: 0) {
                ForEach(tabItems, id: \.self) { value in
                    GeometryReader { reader in
                        TabBarButton(selected: $selected, value: value, centerX: $centerX, rect: reader.frame(in: .global))
                        // setting First Initial Curve
                            .onAppear {
                                if value == tabItems.first {
                                    centerX = reader.frame(in: .global).midX
                                }
                            }
                    }
                    .frame(width: 70, height: 50)
                    
                    if value != tabItems.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 25)
            .padding(.top)
            // For Smaller Size iPhone Padding will be 15
            // No padding for Notch phones
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .background(Color.white.clipShape(AnimatedShape(centerX: centerX)))
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: -5)
            .padding(.top, -15)
            .ignoresSafeArea(.all, edges: .horizontal)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct TabBarButton: View {
    @Binding var selected: String
    var value: String
    @Binding var centerX: CGFloat
    var rect: CGRect
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selected = value
                centerX = rect.midX
            }
        }) {
            VStack {
                Image(value)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 26, height: 26)
                    .foregroundColor(selected == value ? Color("Color") : .gray)
                
                Text(value)
                    .font(.caption)
                    .foregroundColor(.black)
                    .opacity(selected == value ? 1 : 0)
            }
            // Default Frame For Reading Mid X Axis From Curve
            .padding(.top)
            .frame(width: 70, height: 50)
            .offset(y: selected == value ? -15 : 0)
        }
    }
}

struct AnimatedShape: Shape {
    var centerX: CGFloat
    
    // animating Path
    var animatableData: CGFloat {
        get {
            return centerX
        }
        
        set {
            centerX = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            path.move(to: CGPoint(x: 0, y: 15))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 15))
            
            // Curve
            path.move(to: CGPoint(x: centerX - 35, y: 15))
            
            //path.addQuadCurve(to: CGPoint(x: centerX + 35, y: 15), control: CGPoint(x: centerX, y: -30))
            path.addArc(center: CGPoint(x: centerX, y: 25), radius: 35, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: true)
        }
    }
}

var tabItems = ["Home", "Search", "Favourites", "Settings"]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
