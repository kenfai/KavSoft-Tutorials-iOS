//
//  Recipe.swift
//  Recipe
//
//  Created by Ginger on 30/12/2020.
//

import Foundation
import SwiftUI

struct Recipe {
    var image: String
    var title: String
    var detail: String
    var rating: String
    var type: String
    var color: Color
}

var recipes = [
    Recipe(image: "r1", title: "Mexican Egg Mix", detail: "A gentle combination of careully chosen veggies with a Mexican taste.", rating: "4.5", type: "easy", color: Color("blue")),
    Recipe(image: "r2", title: "Italian Baked Dish", detail: "Italian based spicy and green beans baked together with cheese", rating: "4.8", type: "Hard", color: Color("yellow"))
]

var categories = ["Fruits", "Meats", "Sushi", "Fries"]
