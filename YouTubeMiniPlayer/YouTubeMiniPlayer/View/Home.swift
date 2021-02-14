//
//  Home.swift
//  YouTubeMiniPlayer
//
//  Created by Ginger on 14/02/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var player = VideoPlayerViewModel()
    // Gesture State to avoid DragGesture Glitches
    @GestureState var gestureOffset: CGFloat = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(spacing: 15) {
                    ForEach(videos) { video in
                        
                        // Video Card View
                        VideoCardView(video: video)
                            .padding(.horizontal)
                            .onTapGesture {
                                withAnimation {
                                    player.showPlayer = true
                                }
                            }
                    }
                }
            }
            
            // Video Player View
            if player.showPlayer {
                MiniPlayer()
                    // Move from Bottom
                    .transition(.move(edge: .bottom))
                    .offset(y: player.offset)
                    .gesture(DragGesture().updating($gestureOffset, body: { (value, state, _) in
                        state = value.translation.height
                    })
                    .onEnded(onEnd(value:)))
                
            }
        }
        .onChange(of: gestureOffset) { (value) in
            onChanged()
        }
        // Setting Environment Object
        .environmentObject(player)
    }
    
    func onChanged() {
        if gestureOffset > 0 && !player.isMiniPlayer && player.offset + 70 <= player.height {
            player.offset = gestureOffset
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.default) {
            if !player.isMiniPlayer {
                player.offset = 0
                
                // Closing View
                if value.translation.height > UIScreen.main.bounds.height / 3 {
                    player.isMiniPlayer = true
                } else {
                    player.isMiniPlayer = false
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
