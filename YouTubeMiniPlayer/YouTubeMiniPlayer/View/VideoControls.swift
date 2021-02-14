//
//  VideoControls.swift
//  YouTubeMiniPlayer
//
//  Created by Ginger on 14/02/2021.
//

import SwiftUI

struct VideoControls: View {
    @EnvironmentObject var player: VideoPlayerViewModel
    
    var body: some View {
        HStack(spacing: 15) {
            // Video View
            Rectangle()
                .fill(Color.clear)
                .frame(width: 150, height: 70)
            
            VStack(alignment: .leading, spacing: 6) {
                Text("M1 MacBook Unboxing and First Impressions")
                    .font(.callout)
                    .foregroundColor(.black)
                    .lineLimit(1)
                
                Text("Kavsoft")
                    .fontWeight(.bold)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Button(action: {}) {
                Image(systemName: "pause.fill")
                    .font(.title2)
                    .foregroundColor(.black)
            }
            
            Button(action: {
                // withAnimation {
                    player.showPlayer.toggle()
                    player.offset = 0
                    player.isMiniPlayer.toggle()
                // }
            }) {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundColor(.black)
            }
        }
        .padding(.trailing)
    }
}

struct VideoControls_Previews: PreviewProvider {
    static var previews: some View {
        VideoControls()
    }
}
