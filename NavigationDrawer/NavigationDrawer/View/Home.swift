//
//  Home.swift
//  NavigationDrawer
//
//  Created by Ginger on 21/02/2021.
//

import SwiftUI

struct Home: View {
    // Hiding TabBar
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @StateObject var menuData = MenuViewModel()
    
    @Namespace var animation
    
    var body: some View {
        HStack(spacing: 0) {
            // Drawer and Main View
            
            // Drawer
            Drawer(animation: animation)
            
            // Main View
            TabView(selection: $menuData.selectedMenu) {
                
                Catalogue()
                    .tag("Catalogue")
                
                Orders()
                    .tag("Your Orders")
                
                Cart()
                    .tag("Your Cart")
                
                Favourites()
                    .tag("Favourites")
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        // Max Frame
        .frame(width: UIScreen.main.bounds.width)
        // Moving View
        // 250/2 => 125
        .offset(x: menuData.showDrawer ? 125 : -125)
        .overlay(
            ZStack {
                if !menuData.showDrawer {
                    DrawerCloseButton(animation: animation)
                        .padding()
                }
            }, alignment: .topLeading
        )
        .environmentObject(menuData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
