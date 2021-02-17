//
//  InsideTabBarItems.swift
//  SharedTabBar (iOS)
//
//  Created by Ginger on 17/02/2021.
//

import SwiftUI

struct InsideTabBarItems: View {
    @Binding var selectedTab: String

    var body: some View {
        Group {
            
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
                .padding(.horizontal)
                .padding(.top, getDevice() == .iPhone ? 0 : 35)
                .padding(.bottom, getDevice() == .iPhone ? 0 : 15)
            
            TabBarButton(image: "swift", title: "SwiftUI", selectedTab: $selectedTab)
            TabBarButton(image: "book", title: "Beginners", selectedTab: $selectedTab)
            TabBarButton(image: "laptopcomputer", title: "macOS", selectedTab: $selectedTab)
            TabBarButton(image: "person.crop.circle.fill.badge.questionmark", title: "Contact", selectedTab: $selectedTab)
        }
    }
}
