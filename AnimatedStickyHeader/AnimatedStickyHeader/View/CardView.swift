//
//  CardView.swift
//  AnimatedStickyHeader
//
//  Created by Ginger on 12/02/2021.
//

import SwiftUI

struct CardView: View {
    var food: Food
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10, content: {
                Text(food.title)
                    .fontWeight(.bold)
                
                Text(food.description)
                    .font(.caption)
                    .lineLimit(3)
                
                Text(food.price)
                    .fontWeight(.bold)
            })
            
            Spacer(minLength: 10)
            
            Image(food.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 130)
                .cornerRadius(10)
        }
        .padding(.horizontal)
    }
}
