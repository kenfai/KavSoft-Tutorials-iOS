//
//  Drawer.swift
//  NavigationDrawer
//
//  Created by Ginger on 21/02/2021.
//

import SwiftUI

struct Drawer: View {
    @EnvironmentObject var menuData: MenuViewModel
    
    // Animation
    var animation: Namespace.ID

    var body: some View {
        VStack {
            HStack {
                Image("p1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .clipShape(Circle())
                
                Spacer()
                
                // Close Button
                if menuData.showDrawer {
                    DrawerCloseButton(animation: animation)
                }
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 10, content: {
                Text("Hello")
                    .font(.title2)
                
                Text("Jenna Ezarik")
                    .font(.title)
                    .fontWeight(.heavy)
            })
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 5)
            
            // Menu Buttons
            VStack(spacing: 22) {
                MenuButton(name: "Catalogue", image: "envelope.fill", selectedMenu: $menuData.selectedMenu, animation: animation)
                
                MenuButton(name: "Your Cart", image: "bag.fill", selectedMenu: $menuData.selectedMenu, animation: animation)
            
                MenuButton(name: "Favourites", image: "suit.heart.fill", selectedMenu: $menuData.selectedMenu, animation: animation)
            
                MenuButton(name: "Your Orders", image: "list.triangle", selectedMenu: $menuData.selectedMenu, animation: animation)
            }
            .padding(.leading)
            .frame(width: 250, alignment: .leading)
            .padding(.top, 30)
            
            Divider()
                .background(Color.white)
                .padding(.top, 30)
                .padding(.horizontal, 25)
            
            Spacer()
            
            MenuButton(name: "Sign Out", image: "rectangle.righthalf.inset.fill.arrow.right", selectedMenu: .constant(""), animation: animation)
                .padding(.bottom)
        }
        // Default Size
        .frame(width: 250)
        .background(
            Color("drawerBG")
                .ignoresSafeArea(.all, edges: .vertical)
        )
    }
}
