//
//  ContentView.swift
//  CircularSlider
//
//  Created by Ginger on 23/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Home()
                .preferredColorScheme(.dark)
                .navigationTitle("Wallet")
        }
    }
}

struct Home: View {
    @State var size = UIScreen.main.bounds.width - 100
    @State var progress: CGFloat = 0
    @State var angle: Double = 0
    @State var scale: CGFloat = 1.0
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(Color("stroke"), style: StrokeStyle(lineWidth: 50, lineCap: .butt))
                    .frame(width: size, height: size)
                
                // progress
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 50, lineCap: .round, lineJoin: .round))
                    .frame(width: size, height: size)
                    .rotationEffect(Angle(degrees: -89)) // +1 degree to hide bleed edge
                
                // Inner finish curve
                Circle()
                    .fill(Color("stroke"))
                    .frame(width: 50, height: 50)
                    .offset(x: size / 2)
                    .rotationEffect(Angle(degrees: -90))
                
                // Drag Circle
                Circle()
                    .fill(Color.white)
                    .frame(width: 50, height: 50)
                    .scaleEffect(scale)
                    .offset(x: size / 2)
                    .rotationEffect(Angle(degrees: angle))
                // adding gesture
                    .gesture(DragGesture().onChanged(onDrag(value:)).onEnded({_ in
                        withAnimation {
                            scale = 1.0
                        }
                    }))
                    .rotationEffect(Angle(degrees: -89))
                
                // sample $200
                Text("$" + String(format: "%.0f", progress * 200))
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
        }
    }
    
    func onDrag(value: DragGesture.Value) {
        // calculating radians
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        
        // since atan2() will return from -180 to 180
        // elimination drag gesture size
        // size = 55 => Radians = 27.5
        let radians = atan2(vector.dy - 25, vector.dx - 25)
        
        // converting to angle
        var angle = radians * 180 / .pi
        
        // simple technique for 0 to 360
        if angle < 0 {
            angle = 360 + angle
        }
        
        withAnimation(Animation.linear(duration: 0.15)) {
            // progress
            let progress = angle / 360
            self.progress = progress
            self.angle = Double(angle)
            
            self.scale = 1.4
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
