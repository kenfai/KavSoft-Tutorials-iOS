//
//  AppItem.swift
//  NavigationSearchBar
//
//  Created by Ginger on 01/02/2021.
//

import SwiftUI

// Model and Sample Data
struct AppItem: Identifiable {
    
    var id = UUID().uuidString
    // both Image and Name are same
    var name: String
    // since all are Apple Native Apps
    var source: String = "Apple"
}

var apps = [
    AppItem(name: "App Store"),
    AppItem(name: "Calculator"),
    AppItem(name: "Calendar"),
    AppItem(name: "Camera"),
    AppItem(name: "Clock"),
    AppItem(name: "Facetime"),
    AppItem(name: "Health"),
    AppItem(name: "Mail"),
    AppItem(name: "Maps"),
    AppItem(name: "Messages"),
    AppItem(name: "News"),
    AppItem(name: "Phone"),
    AppItem(name: "Photos"),
    AppItem(name: "Safari"),
    AppItem(name: "Settings"),
    AppItem(name: "Stocks"),
    AppItem(name: "Wallet"),
    AppItem(name: "Weather"),
]
