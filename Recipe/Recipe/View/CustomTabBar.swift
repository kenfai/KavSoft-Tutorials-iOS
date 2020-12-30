//
//  CustomTabBar.swift
//  Recipe
//
//  Created by Ginger on 30/12/2020.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack {
            TabButton(title: "Home", selectedTab: $selectedTab)
            
            Spacer(minLength: 0)
            
            Button(action: {}) {
                Image("plus")
                    .renderingMode(.original)
                    .padding(.vertical)
                    .padding(.horizontal, 25)
                    .background(Color("orange"))
                    .cornerRadius(15)
            }
            
            Spacer(minLength: 0)
            
            TabButton(title: "Saved", selectedTab: $selectedTab)
        }
        .padding(.top)
        .padding(.horizontal, 22)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        .background(Color.white)
        .clipShape(CustomCorner(corners: [.topLeft, .topRight], size: 55))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: -5)
    }
}

struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            selectedTab = title
        }) {
            HStack(spacing: 10) {
                Image(title)
                    .renderingMode(.template)
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? Color("yellow") : .gray)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .background(Color("yellow").opacity(selectedTab == title ? 0.15 : 0))
            .clipShape(Capsule())
        }
    }
}
