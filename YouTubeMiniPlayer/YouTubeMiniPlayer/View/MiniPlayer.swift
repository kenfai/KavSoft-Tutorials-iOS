//
//  MiniPlayer.swift
//  YouTubeMiniPlayer
//
//  Created by Ginger on 14/02/2021.
//

import SwiftUI

struct MiniPlayer: View {
    // ScreenHeight
    @EnvironmentObject var player: VideoPlayerViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            // Video Player
            HStack {
                VideoPlayerView()
                    .frame(width: player.isMiniPlayer ? 150 : player.width, height: player.isMiniPlayer ? 70 : getFrame())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                // Controls
                VideoControls()
            )
            
            GeometryReader { reader in
                ScrollView {
                    VStack(spacing: 18) {
                        // Video Playback Details and Buttons
                        VStack(alignment: .leading, spacing: 8) {
                            Text("M1 MacBook Unboxing and First Impressions")
                                .font(.callout)
                            
                            Text("1.2M Views")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Buttons
                        HStack {
                            PlayBackVideoButtons(image: "hand.thumbsup", text: "123K")
                            
                            PlayBackVideoButtons(image: "hand.thumbsdown", text: "1K")
                            
                            PlayBackVideoButtons(image: "square.and.arrow.up", text: "Share")
                            
                            PlayBackVideoButtons(image: "square.and.arrow.down", text: "Download")
                            
                            PlayBackVideoButtons(image: "message", text: "Live Chat")
                        }
                        
                        Divider()
                        
                        VStack(spacing: 15) {
                            ForEach(videos) { video in
                                
                                // Video Card View
                                VideoCardView(video: video)
                            }
                        }
                    }
                    .padding()
                }
                .onAppear {
                    player.height = reader.frame(in: .global).height + 250
                }
            }
            .background(Color.white)
            .opacity(player.isMiniPlayer ? 0 : getOpacity())
            .frame(height: player.isMiniPlayer ? 0 : nil)
        }
        .background(
            Color.white
                .ignoresSafeArea(.all, edges: .all)
                .onTapGesture {
                    withAnimation {
                        player.width = UIScreen.main.bounds.width
                        player.isMiniPlayer.toggle()
                    }
                }
        )
    }
    
    // Getting Frame and Opacity while Dragging
    func getFrame() -> CGFloat {
        
        let progress = player.offset / (player.height - 100)
        
        if (1 - progress) <= 1.0 {
            
            let videoHeight: CGFloat = (1 - progress) * 250
            
            // stopping height at 70
            if videoHeight <= 70 {
                
                // Decresing Width
                let percent = videoHeight / 70
                let videoWidth: CGFloat = percent * UIScreen.main.bounds.width
                
                DispatchQueue.main.async {
                    // Stopping at 150
                    if videoWidth >= 150 {
                        player.width = videoWidth
                    }
                }
                
                return 70
            }
            
            // Preview will Have Animation Problems
            DispatchQueue.main.async {
                player.width = UIScreen.main.bounds.width
            }
            
            return videoHeight
        }
        
        return 250
    }
    
    func getOpacity() -> Double {
        
        let progress = player.offset / (player.height)
        if progress <= 1 {
            return Double(1 - progress)
        }
        
        return 1
    }
}

struct MiniPlayer_Previews: PreviewProvider {
    static var previews: some View {
        MiniPlayer()
    }
}
