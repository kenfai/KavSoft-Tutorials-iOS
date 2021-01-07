//
//  ColorButton.swift
//  ShopBag
//
//  Created by Ginger on 07/01/2021.
//

import SwiftUI

struct ColorButton: View {
    var color: Color
    @Binding var selectedColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .fill(color)
                .frame(width: 20, height: 20)
            
            Circle()
                .stroke(Color.black.opacity(selectedColor == color ? 1 : 0), lineWidth: 1)
                .frame(width: 30, height: 30)
        }
        .onTapGesture {
            withAnimation {
                selectedColor = color
            }
        }
    }
}
