//
//  TabButton.swift
//  ShopBag
//
//  Created by Ginger on 07/01/2021.
//

import SwiftUI

struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedTab = title
            }
        }) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .fontWeight(.heavy)
                    .foregroundColor(selectedTab == title ? .black : .gray)
                
                if selectedTab == title {
                    Capsule()
                        .fill(Color.black)
                        .frame(width: 40, height: 4)
                        .matchedGeometryEffect(id: "Tab", in: animation)
                }
            }
            .frame(width: 100)
        }
    }
}
