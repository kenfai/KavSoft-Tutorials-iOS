//
//  ChipData.swift
//  ChipsView
//
//  Created by Ginger on 18/02/2021.
//

import SwiftUI

struct ChipData: Identifiable, Hashable {
    
    var id = UUID().uuidString
    var chipText: String
    // To stop Auto Update
    var isExceeded = false
}
