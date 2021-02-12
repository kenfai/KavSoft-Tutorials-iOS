//
//  Tab.swift
//  AnimatedStickyHeader
//
//  Created by Ginger on 12/02/2021.
//

import SwiftUI

// Tab Model with Tab items

struct Tab: Identifiable {
    
    var id = UUID().uuidString
    var tab: String
    var foods: [Food]
}

var tabsItems = [
    Tab(tab: "Order Again", foods: foods.shuffled()),
    Tab(tab: "Picked For You", foods: foods.shuffled()),
    Tab(tab: "Starters", foods: foods.shuffled()),
    Tab(tab: "Gimpub Sushi", foods: foods.shuffled()),
]
