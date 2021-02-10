//
//  Place.swift
//  AdvanceMapKit
//
//  Created by Ginger on 10/02/2021.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    
    var id = UUID().uuidString
    var placemark: CLPlacemark
}
