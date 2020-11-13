//
//  ContentView.swift
//  AppleMusicAnimation
//
//  Created by Ginger on 13/11/2020.
//

import SwiftUI

struct Song {
    var id: String
    var title: String
    var artist: String
}
let songs: [Song] = [
    Song(id: "adele", title: "Someone Like You", artist: "Adele"),
    Song(id: "coldplay", title: "Hymn For The Weekend", artist: "Coldplay"),
    Song(id: "ed-sheeran", title: "Thinking Out Loud", artist: "Ed Sheeran"),
    Song(id: "taylor-swift", title: "You Need To Calm Down", artist: "Taylor Swift")
]

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @Namespace var namespace
    
    @State var show = false
    @State var progress: CGFloat = 0
    @State var playing = false
    @State var currentSong = 0
    @State var fade = 1.0
    
    var body: some View {
        VStack {
            if !show {
                Spacer()
            }
            
            // Minimised View
            VStack(spacing: 35) {

                HStack(spacing: 15) {
                    // resizing image
                    Image("\(songs[currentSong].id)-album")
                        .resizable()
                        .frame(width: show ? 250 : 50, height: show ? 250 : 50)
                        .scaledToFill()
                        .opacity(fade)
                        .background(Color.black)
                        .padding(.top, show ? 35 : 0)
                    
                    // hiding view if it's expanded
                    if !show {
                    
                        VStack(alignment: .leading, spacing: 4) {
                            Text(songs[currentSong].title)
                            
                            Text(songs[currentSong].artist)
                                .foregroundColor(.red)
                        }
                        .matchedGeometryEffect(id: "Details", in: namespace)
                        
                        Spacer()
                        
                        Button(action: {
                            playing.toggle()
                        }) {
                            Image(systemName: playing ? "pause.fill" : "play.fill")
                                .font(.title)
                                .foregroundColor(.black)
                                .frame(width: 30)
                        }
                        .matchedGeometryEffect(id: "play", in: namespace)
                    }
                }
                .padding(.bottom, 30)
                
                // moving view up
                if show {
                    VStack(alignment: .center, spacing: 4) {
                        Text(songs[currentSong].title)
                        
                        Text(songs[currentSong].artist)
                            .foregroundColor(.red)
                    }
                    .matchedGeometryEffect(id: "Details", in: namespace)
                    
                    Slider(value: $progress)
                    
                    HStack {
                        Button(action: {
                            withAnimation(Animation.easeIn(duration: 0.1)) {
                                fade = 0.6
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if currentSong <= 0 {
                                    currentSong = songs.count - 1
                                } else {
                                    currentSong -= 1
                                }
                                withAnimation(Animation.easeOut(duration: 0.1)) {
                                    fade = 1.0
                                }
                            }
                        }) {
                            Image(systemName: "backward.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            playing.toggle()
                        }) {
                            Image(systemName: playing ? "pause.fill" : "play.fill")
                                .font(.title)
                                .foregroundColor(.black)
                                .frame(width: 30)
                        }
                        // only for play button
                        .matchedGeometryEffect(id: "play", in: namespace)
                        
                        Spacer()
                        
                        Button(action: {
                            withAnimation(Animation.easeIn(duration: 0.1)) {
                                fade = 0.6
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if currentSong >= songs.count - 1 {
                                    currentSong = 0
                                } else {
                                    currentSong += 1
                                }
                                withAnimation(Animation.easeOut(duration: 0.1)) {
                                    fade = 1.0
                                }
                            }
                        }) {
                            Image(systemName: "forward.fill")
                                .font(.title)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    HStack {
                        Button(action: {}) {
                            Image(systemName: "square.and.arrow.down.fill")
                                .foregroundColor(.black)
                                .font(.title)
                        }
                        
                        Spacer()
                    }
                    .padding()
                }
            }
            .padding(.all)
            .background(Color.white.shadow(radius: 3))
            .onTapGesture {
                withAnimation(.easeOut(duration: 0.4)) {
                    show.toggle()
                }
            }
        }
        .background(Color.black.opacity(0.06))
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
