//
//  TabBarButton.swift
//  SharedTabBar (iOS)
//
//  Created by Ginger on 17/02/2021.
//

import SwiftUI

struct TabBarButton: View {
    var image: String
    var title: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                selectedTab = title
            }
        }) {
            VStack(spacing: 6) {
                Image(systemName: image)
                    .font(.system(size: getDevice() == .iPhone ? 30 : 25))
                // For Dark Mode Adoption
                    .foregroundColor(selectedTab == title ? .white : .primary)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.semibold)
                    // For Dark Mode Adoption
                    .foregroundColor(selectedTab == title ? .white : .primary)
            }
            .padding(.bottom, 8)
            // Total Four Tabs
            .frame(width: self.getDevice() == .iPhone ? (self.getScreen().width - 75) / 4 : 100, height: 55 + self.getSafeAreaBottom())
            .contentShape(Rectangle())
            // Bottom up Effect
            // if iPad or macOS moving effect will be from left
            .background(Color("purple").offset(x: selectedTab == title ? 0 : getDevice() == .iPhone ? 0 : -100, y: selectedTab == title ? 0 : getDevice() == .iPhone ? 100 : 0))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
