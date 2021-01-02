//
//  Option.swift
//  WheelRadialPicker
//
//  Created by Ginger on 02/01/2021.
//

import SwiftUI

struct Option: View {
    var image: String
    
    var body: some View {
        Button(action: {}) {
            Image(systemName: image)
                .font(.title2)
                .foregroundColor(.white)
        }
    }
}
