//
//  FunctionButton.swift
//  WheelRadialPicker
//
//  Created by Ginger on 02/01/2021.
//

import SwiftUI

struct FunctionButton: View {
    var image: String
    var angle: Double
    @State var circleWidth = UIScreen.main.bounds.width / 1.5
    @Binding var current: Int
    var index: Int
    
    var body: some View {
        Image(systemName: image)
            .font(.system(size: 24, weight: .heavy))
            .foregroundColor(.black)
            // undo its image rotation
            .rotationEffect(Angle(degrees: -angle))
            .padding()
            .background(Color.red.opacity(current == index ? 0.5 : 0))
            .clipShape(Circle())
            // Moving All View To Left
            // So Angle will be Perfect
            .offset(x: -circleWidth / 2)
            // this will rotate image
            .rotationEffect(Angle(degrees: angle))
    }
}
