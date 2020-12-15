//
//  ContentView.swift
//  MapsBottomSheet
//
//  Created by Ginger on 15/12/2020.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 3.141, longitude: 101.68653), latitudinalMeters: 10000, longitudinalMeters: 10000)
    @State var offset: CGFloat = 0
    
    @State var startLocationY: CGFloat = 0
    @State var translationHeight: CGFloat = 0
    @State var translationWidth: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            Map(coordinateRegion: $region)
                .ignoresSafeArea(.all, edges: .all)
            
            GeometryReader { geo in
                Text("width:\(geo.frame(in: .global).width) height:\(geo.frame(in: .global).height) maxX:\(geo.frame(in: .global).maxX) midX:\(geo.frame(in: .global).midX) midY:\(geo.frame(in: .global).midY) maxY:\(geo.frame(in: .global).maxY) startLocation.y:\(startLocationY) translation.width:\(translationWidth) translation.height:\(translationHeight) offset:\(offset)")
                
                // to read frame height
                BottomSheet(offset: $offset, value: (-geo.frame(in: .global).height + 150))
                    .offset(y: geo.frame(in: .global).height - 140)
                // adding Gesture
                    .offset(y: offset)
                    .gesture(DragGesture().onChanged({ value in
                        startLocationY = value.startLocation.y
                        translationHeight = value.translation.height
                        translationWidth = value.translation.width
                        
                        withAnimation {
                            // checking Scroll direction
                            // scrolling upwards
                            // usingstartLocation because translation will change when we drag up and down
                            if value.startLocation.y > geo.frame(in: .global).midX {
                                if value.translation.height < 0 && offset > (-geo.frame(in: .global).height + 150) {
                                    offset = value.translation.height
                                }
                            }
                            
                            if value.startLocation.y < geo.frame(in: .global).midX {
                                if value.translation.height > 0 && offset < 0 {
                                    offset = (-geo.frame(in: .global).height + 150) + value.translation.height
                                }
                            }
                        }
                    }).onEnded({ value in
                        withAnimation {
                            // checking and pulling up the screen
                            if value.startLocation.y > geo.frame(in: .global).midX {
                                if -value.translation.height > geo.frame(in: .global).midX {
                                    offset = (-geo.frame(in: .global).height + 150)
                                    
                                    return
                                }
                                
                                offset = 0
                            }
                            
                            if value.startLocation.y < geo.frame(in: .global).midX {
                                if value.translation.height < geo.frame(in: .global).midX {
                                    offset = (-geo.frame(in: .global).height + 150)
                                    
                                    return
                                }
                                
                                offset = 0
                            }
                        }
                    }))
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

struct BottomSheet: View {
    @State var txt = ""
    @Binding var offset: CGFloat
    var value: CGFloat
    
    var body: some View {
        VStack {
            Capsule()
                .fill(Color.gray.opacity(0.5))
                .frame(width: 50, height: 5)
                .padding(.top)
                .padding(.bottom, 5)
            
            HStack(spacing: 15) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 22))
                    .foregroundColor(.gray)
                
                TextField("Search Place", text: $txt) { status in
                    withAnimation {
                        offset = value
                    }
                } onCommit: {
                    
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            // BlurView
            // For Dark Mode Adoption
            .background(BlurView(style: .systemMaterial))
            .cornerRadius(15)
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 15) {
                    ForEach(1...15, id: \.self) { count in
                        Text("Searched Place")
                        
                        Divider()
                            .padding(.top, 10)
                    }
                }
                .padding()
                .padding(.top)
            }
        }
        .background(BlurView(style: .systemMaterial))
        .cornerRadius(15)
    }
}

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> some UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
