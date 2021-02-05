//
//  Rings.swift
//  VPNComplexUI
//
//  Created by Ginger on 05/02/2021.
//

import SwiftUI

struct Rings: View {
    var width: CGFloat
    @Binding var isServerOn: Bool
    
    var body: some View {
        ZStack {
            ForEach(1...60, id: \.self) { index in
                
                Circle()
                    .fill(isServerOn ? Color.green : Color.white)
                    .frame(width: getSize(index: index), height: getSize(index: index))
                    .offset(x: -(width / 2))
                    .rotationEffect(Angle(degrees: Double(index) * 6))
                    .opacity(getSize(index: index) == 3 ? 0.7 : (isServerOn ? 1 : 0.8))
            }
        }
        .frame(width: width)
        .rotationEffect(Angle(degrees: 90))
    }
    
    func getSize(index: Int) -> CGFloat {
        // Different Size Based on Index
        if index < 10 || index > 50 {
            return 3
        }
        
        if index >= 10 && index < 20 {
            return 4
        }
        
        if index >= 40 && index <= 50 {
            return 4
        } else {
            return 5
        }
    }
}
