//
//  CustomButtonModifier.swift
//  LoginViewModifier
//
//  Created by Ginger on 12/01/2021.
//

import SwiftUI

struct CustomButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.white)
            .padding(.vertical)
            .padding(.horizontal, 35)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color("yellow-light"), Color("yellow")]), startPoint: .leading, endPoint: .trailing)
            )
            .clipShape(Capsule())
    }
}
