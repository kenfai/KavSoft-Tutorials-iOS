//
//  Item.swift
//  FoodSideTabBar
//
//  Created by Ginger on 16/01/2021.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID().uuidString
    var title: String
    var cost: String
    var image: String
}

var items = [
    Item(title: "Orange Juice Shake", cost: "$6", image: "shake1"),
    Item(title: "Strawberry Juice Shake", cost: "$10", image: "shake2")
]
