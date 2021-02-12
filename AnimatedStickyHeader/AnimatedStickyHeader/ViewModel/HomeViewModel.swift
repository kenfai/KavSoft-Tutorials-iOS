//
//  HomeViewModel.swift
//  AnimatedStickyHeader
//
//  Created by Ginger on 12/02/2021.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var offset: CGFloat = 0
    
    // Selected Tab
    @Published var selectedtab = tabsItems.first!.tab
}
