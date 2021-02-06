//
//  BillShape.swift
//  BillSplit
//
//  Created by Ginger on 06/02/2021.
//

import SwiftUI

struct BillShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            
            path.move(to: CGPoint(x: 0, y: 80))
            path.addArc(center: CGPoint(x: 0, y: 80), radius: 20, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 90), clockwise: false)
            
            path.move(to: CGPoint(x: rect.width, y: 80))
            path.addArc(center: CGPoint(x: rect.width, y: 80), radius: 20, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: -90), clockwise: false)
        }
    }
}
