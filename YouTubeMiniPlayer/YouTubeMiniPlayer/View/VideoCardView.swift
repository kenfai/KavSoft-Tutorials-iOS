//
//  VideoCardView.swift
//  YouTubeMiniPlayer
//
//  Created by Ginger on 14/02/2021.
//

import SwiftUI

struct VideoCardView: View {
    var video: Video
    
    var body: some View {
        VStack(spacing: 10) {
            Image(video.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
            
            HStack(spacing: 15) {
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(video.title)
                        .fontWeight(.semibold)
                        .font(.callout)
                    
                    HStack {
                        Text("Kavsoft")
                            .fontWeight(.bold)
                            .font(.caption)
                        
                        Text(".12K Views.5 Days Ago")
                            .font(.caption)
                    }
                    .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal)
    }
}
