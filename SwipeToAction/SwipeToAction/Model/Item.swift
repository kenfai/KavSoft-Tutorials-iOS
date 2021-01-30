//
//  Item.swift
//  SwipeToAction
//
//  Created by Ginger on 30/01/2021.
//

import SwiftUI

struct Item: Identifiable {
    
    var id = UUID().uuidString
    var title: String
    var price: String
    var subTitle: String
    var image: String
    var offset: CGFloat = 0
}
