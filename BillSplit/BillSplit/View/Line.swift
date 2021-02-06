//
//  Line.swift
//  BillSplit
//
//  Created by Ginger on 06/02/2021.
//

import SwiftUI

struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { path in
            
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
        }
    }
}
