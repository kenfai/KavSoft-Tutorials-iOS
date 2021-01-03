//
//  Item.swift
//  FoodSmoothCurves
//
//  Created by Ginger on 03/01/2021.
//

import SwiftUI

struct Item: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var price: String
    var color: Color
    var detail: String
}

var items: [Item] = [
    Item(image: "sweet", title: "Sweet soda", price: "$8", color: Color("Color"), detail: ""),
    Item(image: "colessumdonut", title: "Colosseum Donut", price: "$14", color: Color("Color1"), detail: ""),
    Item(image: "seriouslama", title: "Serious lama", price: "$36", color: Color("Color2"), detail: ""),
    Item(image: "nyasaicecream", title: "Nyasha ice cream", price: "$19", color: Color("Color3"), detail: ""),
]
