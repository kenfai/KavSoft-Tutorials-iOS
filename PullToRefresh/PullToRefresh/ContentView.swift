//
//  ContentView.swift
//  PullToRefresh
//
//  Created by Ginger on 20/01/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var arrayData = ["Hello Data 1", "Hello Data 2", "Hello Data 3", "Hello Data 4", "Hello Data 5"]
    @State var refresh = Refresh(started: false, released: false)

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("Kavsoft")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .foregroundColor(.purple)
                
                Spacer()
            }
            .padding()
            .background(Color.white.ignoresSafeArea(.all, edges: .top))
            
            Divider()
            
            ScrollView(.vertical, showsIndicators: false) {
                // Geometry Reader for calculation position
                GeometryReader { reader -> AnyView in
                    //print(reader.frame(in: .global).minY)
                    DispatchQueue.main.async {
                        
                        if refresh.startOffset == 0 {
                            refresh.startOffset = reader.frame(in: .global).minY
                        }
                        
                        refresh.offset = reader.frame(in: .global).minY
                        
                        if refresh.offset - refresh.startOffset > 80 && !refresh.started {
                            refresh.started = true
                        }
                        
                        // checking if refresh is started and drag is released
                        if refresh.startOffset == refresh.offset && refresh.started && !refresh.released {
                            withAnimation(Animation.linear) {
                                refresh.released = true
                            }
                            updateData()
                        }
                        
                        // checking if invalid becomes valid
                        if refresh.startOffset == refresh.offset && refresh.started && refresh.released && refresh.invalid {
                            refresh.invalid = false
                            updateData()
                        }
                    }
                    
                    return AnyView(Color.black.frame(width: 0, height: 0))
                }
                .frame(width: 0, height: 0)
                
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    
                    if refresh.started && refresh.released {
                        ProgressView()
                            .offset(y: -35)
                    } else {
                        // Arrow and Indicator
                        Image(systemName: "arrow.down")
                            .font(.system(size: 16, weight: .heavy))
                            .foregroundColor(.gray)
                            .rotationEffect(Angle(degrees: refresh.started ? 180 : 0))
                            .offset(y: -25)
                            .animation(.easeIn)
                    }
                    
                    VStack {
                        ForEach(arrayData, id: \.self) { value in
                            HStack {
                                Text(value)
                                
                                Spacer()
                                
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.black)
                            }
                            .padding()
                        }
                    }
                    .background(Color.white)
                }
                .offset(y: refresh.released ? 40 : -10)
            }
        }
        .background(Color.black.opacity(0.06).ignoresSafeArea())
    }
    
    func updateData() {
        // disabling invalid Scroll when data is loading
        
        print("update Data")
        
        // Delaying For Smooth Animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.linear) {
                if refresh.startOffset == refresh.offset {
                    arrayData.append("Updated Data")
                    refresh.released = false
                    refresh.started = false
                } else {
                    refresh.invalid = true
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
