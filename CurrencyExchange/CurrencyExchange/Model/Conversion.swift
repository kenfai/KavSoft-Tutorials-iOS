//
//  Conversion.swift
//  CurrencyExchange
//
//  Created by Ginger on 15/01/2021.
//

import SwiftUI

// For Fetching Data
struct Conversion: Decodable {
    var rates: [String: Double]
    var date: String
    var base: String
}
