//
//  VideoPlayerViewModel.swift
//  YouTubeMiniPlayer
//
//  Created by Ginger on 14/02/2021.
//

import SwiftUI

class VideoPlayerViewModel: ObservableObject {
    // MiniPlayer Properties
    @Published var showPlayer = false
    
    // Gesture Offset
    @Published var offset: CGFloat = 0
    @Published var width: CGFloat = UIScreen.main.bounds.width
    @Published var height: CGFloat = 0
    @Published var isMiniPlayer = false
}
