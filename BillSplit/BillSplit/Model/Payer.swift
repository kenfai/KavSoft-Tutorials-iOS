//
//  Payer.swift
//  BillSplit
//
//  Created by Ginger on 06/02/2021.
//

import SwiftUI

struct Payer: Identifiable {
    
    var id = UUID().uuidString
    var image: String
    var name: String
    var bgColor: Color
    
    // Offset for custom ProgressView
    var offset: CGFloat = 0
    
    var payAmount: CGFloat = 0
}
