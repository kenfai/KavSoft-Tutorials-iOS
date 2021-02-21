//
//  DrawerCloseButton.swift
//  NavigationDrawer
//
//  Created by Ginger on 21/02/2021.
//

import SwiftUI

struct DrawerCloseButton: View {
    
    @EnvironmentObject var menuData: MenuViewModel
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                menuData.showDrawer.toggle()
            }
        }, label: {
            VStack(spacing: 5) {
                
                Capsule()
                    .fill(menuData.showDrawer ? Color.white : Color.primary)
                    .frame(width: 35, height: 3)
                    .rotationEffect(Angle(degrees: menuData.showDrawer ? -50 : 0))
                // Adjusting Like X
                // Based on Trail and Error
                    .offset(x: menuData.showDrawer ? 2 : 0, y: menuData.showDrawer ? 9 : 0)
                
                VStack(spacing: 5) {
                    
                    Capsule()
                        .fill(menuData.showDrawer ? Color.white : Color.primary)
                        .frame(width: 35, height: 3)
                    
                    Capsule()
                        .fill(menuData.showDrawer ? Color.white : Color.primary)
                        .frame(width: 35, height: 3)
                    // Moving this View to hide
                        .offset(y: menuData.showDrawer ? -8 : 0)
                }
                // Rotating like XMark
                .rotationEffect(Angle(degrees: menuData.showDrawer ? 50 : 0))
            }
        })
        // Making it a little small
        .scaleEffect(0.8)
        .matchedGeometryEffect(id: "MENU_BUTTON", in: animation)
    }
}

