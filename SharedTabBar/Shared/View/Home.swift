//
//  Home.swift
//  SharedTabBar (iOS)
//
//  Created by Ginger on 17/02/2021.
//

import SwiftUI

struct Home: View {
    // Hiding TabBar
    init() {
        // UITabBar is not available for macOS
        #if os(iOS)
        UITabBar.appearance().isHidden = true
        #endif
    }
        
    // SelectedTab
    @State var selectedTab = "SwiftUI"
    
    // For Dark Mode
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        ZStack(alignment: getDevice() == .iPhone ? .bottom : .leading) {
            // Since TabBar hide option is not available so we can't use native TabBar in macOS
            #if os(iOS)
            TabView(selection: $selectedTab) {
                Color.red
                    .tag("SwiftUI")
                    .ignoresSafeArea(.all, edges: .all)

                Color.blue
                    .tag("Beginners")
                    .ignoresSafeArea(.all, edges: .all)
                
                Color.yellow
                    .tag("macOS")
                    .ignoresSafeArea(.all, edges: .all)
                
                Color.pink
                    .tag("Contact")
                    .ignoresSafeArea(.all, edges: .all)
            }
            #else
            ZStack {
                // Switch case for Changing Views
                switch(selectedTab) {
                case "SwiftUI": Color.red
                case "Beginners": Color.blue
                case "macOS": Color.yellow
                case "Contact": Color.pink
                default: Color.clear
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            #endif
            
            if self.getDevice() == .iPad || self.getDevice() == .macOS {
                
                VStack(spacing: 10) {
                    InsideTabBarItems(selectedTab: $selectedTab)
                    
                    Spacer()
                }
                .background(scheme == .dark ? Color.black : Color.white)
            } else {
                // Custom TabBar
                HStack(spacing: 0) {
                    InsideTabBarItems(selectedTab: $selectedTab)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(scheme == .dark ? Color.black : Color.white)
            }
        }
        .ignoresSafeArea(.all, edges: getDevice() == .iPhone ? .bottom : .all)
        .frame(width: getDevice() == .iPad || getDevice() == .iPhone ? nil : getScreen().width / 1.6, height: getDevice() == .iPad || getDevice() == .iPhone ? nil : getScreen().height - 150)
    }
}

// Getting Screen Width

// Since we are extending View so we can use directly in SwiftUI body by calling the functions

extension View {
    func getScreen() -> CGRect {
        #if os(iOS)
        return UIScreen.main.bounds
        #else
        return NSScreen.main!.visibleFrame
        #endif
    }
    
    // Safe Area Bottom
    func getSafeAreaBottom() -> CGFloat {
        #if os(iOS)
        return UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 10
        #else
        return 10
        #endif
    }
    
    // Getting Device Type
    func getDevice() -> Device {
        #if os(iOS)
        
        // Since there is no direct for Getting iPadOS
        // Alternative way
        if UIDevice.current.model.contains("iPad") {
            return .iPad
        } else {
            return .iPhone
        }
        #else
        return .macOS
        #endif
    }
}

enum Device {
    case iPhone
    case iPad
    case macOS
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
