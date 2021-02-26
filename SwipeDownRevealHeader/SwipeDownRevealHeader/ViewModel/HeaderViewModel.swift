//
//  HeaderViewModel.swift
//  SwipeDownRevealHeader
//
//  Created by Ginger on 26/02/2021.
//

import SwiftUI

class HeaderViewModel: ObservableObject {
    // To Capture Start MinY value for calculations
    @Published var startMinY: CGFloat = 0
    
    @Published var offset: CGFloat = 0
    
    // HeaderView Properties
    @Published var headerOffset: CGFloat = 0
    
    // It will be used for getting top and bottom offsets for HeaderView
    @Published var topScrollOffset: CGFloat = 0
    @Published var bottomScrollOffset: CGFloat = 0
}
