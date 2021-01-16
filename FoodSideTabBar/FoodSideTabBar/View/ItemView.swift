//
//  ItemView.swift
//  FoodSideTabBar
//
//  Created by Ginger on 16/01/2021.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .fontWeight(.heavy)
                        
                        Text(item.cost)
                            .fontWeight(.heavy)
                    }
                    .foregroundColor(.white)
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image(systemName: "suit.heart")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                }
                .padding([.horizontal, .top])
                .padding(.bottom, -15)
                
                Image(item.image)
                    .offset(x: -30)
            }
            .background(
                Color(item.image)
                    .cornerRadius(35)
                    .clipShape(ItemCurve())
                    //.overlay(ItemCurve().stroke(Color.green)) // for debug
                    .padding(.bottom, 35)
            )
            
            Button(action: {}) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color(item.image))
                    .clipShape(Circle())
            }
            .offset(y: -18)
        }
    }
}
