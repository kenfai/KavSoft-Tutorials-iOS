//
//  BagModel.swift
//  ShopBag
//
//  Created by Ginger on 07/01/2021.
//

import SwiftUI

struct BagModel: Identifiable {
    var id = UUID().uuidString
    var image: String
    var title: String
    var price: String
}

var bags = [
    BagModel(image: "bag1", title: "Office Bag", price: "$234"),
    BagModel(image: "bag2", title: "Belt Bag", price: "$294"),
    BagModel(image: "bag3", title: "Hang Top", price: "$204"),
    BagModel(image: "bag4", title: "Old Fashion", price: "$334"),
    BagModel(image: "bag5", title: "Stylus Bag", price: "$434"),
    BagModel(image: "bag6", title: "Round Belt", price: "$134"),
]

var scrollTabs = ["Hand Bags", "Jewellery", "Footwear", "Dresses", "Beauty"]
