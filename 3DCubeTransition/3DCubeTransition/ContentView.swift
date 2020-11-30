//
//  ContentView.swift
//  3DCubeTransition
//
//  Created by Ginger on 30/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    var width = UIScreen.main.bounds.width
    
    var body: some View {
        TabView {
            ForEach(data) { story in
                GeometryReader { geo in
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color("top"), story.color]), startPoint: .top, endPoint: .bottomTrailing)
                            .cornerRadius(10)
                        
                        Image(story.story)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                Capsule()
                                    .fill(Color.black.opacity(0.3))
                                    .frame(height: 2.5)
                                
                                Capsule()
                                    .fill(Color.white)
                                    .frame(width: story.offset, height: 2.5)
                            }
                            
                            HStack(spacing: 12) {
                                Image(story.story)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                                
                                Text(story.name)
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                
                                Text(story.time)
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                        }
                        .padding(.all)
                    }
                    // setting Frame
                    .frame(width: geo.frame(in: .global).width, height: geo.frame(in: .global).height)
                    // rotating View
                    .rotation3DEffect(Angle(degrees: getAngle(xOffset: geo.frame(in: .global).minX)),
                                      axis: (x: 0.0, y: 1.0, z: 0.0),
                                      // anchoring View based on user drag
                                      anchor: geo.frame(in: .global).minX > 0 ? .leading : .trailing,
                                      // perspective is ZStack Perspective
                                      perspective: 2.5
                    )
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
    
    func getAngle(xOffset: CGFloat) -> Double {
        // since each view is placed at center
        // so half of the width is used to calculate the degree
        
        let tempAngle = xOffset / (width / 2)
        let rotationDegree: CGFloat = 25
        // you can provide your own rotation angle
        
        return Double(tempAngle * rotationDegree)
    }
}

// Sample Data
struct Story: Identifiable {
    var id = UUID().uuidString
    var story: String
    var name: String
    var time: String
    var offset: CGFloat
    var color: Color
}

var data = [
    Story(story: "p1", name: "Catherine", time: "11h", offset: 100, color: .yellow),
    Story(story: "p2", name: "Justine", time: "1h", offset: 200, color: .blue),
    Story(story: "p3", name: "Emily", time: "3h", offset: 50, color: .black),
    Story(story: "p4", name: "Juliana", time: "8h", offset: 250, color: .gray),
    Story(story: "p5", name: "Emma", time: "22h", offset: 80, color: .purple)
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
