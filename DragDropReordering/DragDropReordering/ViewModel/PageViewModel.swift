//
//  PageViewModel.swift
//  DragDropReordering
//
//  Created by Ginger on 16/02/2021.
//

import SwiftUI

class PageViewModel: ObservableObject {
    
    // Selected tab
    @Published var selectedTab = "tabs"
    
    @Published var urls = [
        
        Page(url: URL(string: "https://www.google.com")!),
        Page(url: URL(string: "https://www.yahoo.com")!),
        Page(url: URL(string: "https://www.apple.com")!),
        Page(url: URL(string: "https://www.amazon.com")!),
        Page(url: URL(string: "https://www.swift.org")!),
        Page(url: URL(string: "https://www.microsoft.com")!),
        Page(url: URL(string: "https://aws.amazon.com")!),
        Page(url: URL(string: "https://reactnative.dev")!),
        Page(url: URL(string: "https://www.java.com")!),
        Page(url: URL(string: "https://www.gmail.com")!),
        Page(url: URL(string: "https://unsplash.com")!)
    ]
    
    // Currently Dragging Page
    @Published var currentPage: Page?
}
