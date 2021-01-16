//
//  ItemCurve.swift
//  FoodSideTabBar
//
//  Created by Ginger on 16/01/2021.
//

import SwiftUI

struct ItemCurve: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            // Curve
            let width = rect.width
            let midY = rect.height / 2
            
            path.move(to: CGPoint(x: width, y: midY - 60))
            
            let to = CGPoint(x: width - 42, y: midY)
            let control1 = CGPoint(x: width, y: midY - 30)
            let control2 = CGPoint(x: width - 42, y: midY - 30)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            
            let to2 = CGPoint(x: width, y: midY + 60)
            let control3 = CGPoint(x: width - 42, y: midY + 30)
            let control4 = CGPoint(x: width, y: midY + 30)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
        }
    }
}
