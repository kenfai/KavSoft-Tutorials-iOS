//
//  ContentView.swift
//  VerticalCarousel
//
//  Created by Ginger on 10/12/2020.
//

import SwiftUI
import AVKit

struct ContentView: View {
    var body: some View {
        NavigationView() {
            Home()
                .preferredColorScheme(.dark)
                .navigationTitle("")
                .navigationBarHidden(true)
        }
    }
}

struct Home: View {
    @State var index = 0
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    // creating sample video array
    @State var videos = [
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/bigbuckbunny/mp4/h264/360/Big_Buck_Bunny_360_10s_1MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/jellyfish/mp4/h264/360/Jellyfish_360_10s_1MB.mp4")!),
        AVPlayer(url: URL(string: "https://test-videos.co.uk/vids/sintel/mp4/av1/360/Sintel_360_10s_1MB.mp4")!),
    ]
    
    var body: some View {
        TabView(selection: $index) {
            ForEach(0..<videos.count, id: \.self) { i in
                // simple vertical tab bar
                // cross verification
                Player(video: $videos[i])
                .rotationEffect(Angle(degrees: -90))
                // setting width
                .frame(width: UIScreen.main.bounds.width)
                // to find current index
                // setting tag for each video
                .tag(i)
            }
            // whenever index changes
            // ie tab changes, pausing all other videos and play current one
            .onChange(of: index) { (_) in
                for i in 0..<videos.count {
                    videos[i].pause()
                }
                
                // playing current Video
                videos[index].play()
            }
        }
        .rotationEffect(Angle(degrees: 90))
        // if view is Rotated means Width will be equal to Height
        // removing edges value
        .frame(width: UIScreen.main.bounds.height - (edges!.top + edges!.bottom))
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .background(Color.black.ignoresSafeArea(.all, edges: .all))
        
        // simple Logic - Rotating Views and changing Width & Height
    }
}

// Building TikTok video Player
struct Player: View {
    @Binding var video: AVPlayer
    
    var body: some View {
        VideoPlayer(player: video)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
