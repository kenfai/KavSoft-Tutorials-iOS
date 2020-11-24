//
//  ContentView.swift
//  CurvedTabBar
//
//  Created by Ginger on 24/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var index = 0
    @State var curvePos: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Color("Color")
            
            // Tab Bar
            HStack {
                // using it for reading curve position
                
                TabButton(image: "home", item: 0, index: $index, curvePos: $curvePos)
                
                Spacer(minLength: 0)
                
                TabButton(image: "search", item: 1, index: $index, curvePos: $curvePos)
                
                Spacer(minLength: 0)
                
                TabButton(image: "cart", item: 2, index: $index, curvePos: $curvePos)
                
                Spacer(minLength: 0)
                
                TabButton(image: "account", item: 3, index: $index, curvePos: $curvePos)
            }
            .padding(.horizontal, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 25 : 35)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 8 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
            .padding(.top, 12)
            // Curve
            .background(Color.white.clipShape(CShape(curvePos: curvePos)))
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TabButton: View {
    var image: String
    var item: Int
    @Binding var index: Int
    @Binding var curvePos: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Button(action: {
                    withAnimation(.spring()) {
                        index = item
                        curvePos = geo.frame(in: .global).midX
                    }
                }) {
                    Image(image)
                        .renderingMode(.template)
                        .resizable()
                        .foregroundColor(index == item ? .black : .gray)
                        .frame(width: 28, height: 28)
                        .padding(.all, 15)
                        .background(Color.white.opacity(index == item ? 1 : 0).clipShape(Circle()))
                        .offset(y: index == item ? -35 : 0)
                }
            }
            // 28 + padding 15 = 43
            .frame(width: 43, height: 43)
            .onAppear {
                // getting initial index position
                if item == 0 {
                    DispatchQueue.main.async {
                        curvePos = geo.frame(in: .global).midX
                    }
                }
            }
        }
        .frame(width: 43, height: 43)
    }
}

struct CShape: Shape {
    var curvePos: CGFloat
    
    // animating Path
    var animatableData: CGFloat {
        get {
            return curvePos
        }
        set {
            curvePos = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            // adding Curve
            path.move(to: CGPoint(x: curvePos + 40, y: 0))
            path.addArc(center: CGPoint(x: curvePos, y: 0), radius: CGFloat(40), startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 180), clockwise: false)
            //path.addQuadCurve(to: CGPoint(x: curvePos - 40, y: 0), control: CGPoint(x: curvePos, y: 70))
            
            // using this we can control curve length
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
