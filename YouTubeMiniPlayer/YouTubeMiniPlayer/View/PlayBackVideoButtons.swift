//
//  PlayBackVideoButtons.swift
//  YouTubeMiniPlayer
//
//  Created by Ginger on 14/02/2021.
//

import SwiftUI

struct PlayBackVideoButtons: View {
    var image: String
    var text: String

    var body: some View {
        Button(action: {}) {
            VStack(spacing: 8) {
                Image(systemName: image)
                    .font(.title3)
                
                Text(text)
                    .fontWeight(.semibold)
                    .font(.caption)
            }
        }
        .foregroundColor(.black)
        .frame(maxWidth: .infinity)
    }
}
