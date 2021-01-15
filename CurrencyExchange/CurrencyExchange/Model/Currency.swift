//
//  Currency.swift
//  CurrencyExchange
//
//  Created by Ginger on 15/01/2021.
//

import SwiftUI

// For Displaying Data
struct Currency: Identifiable {
    var id = UUID().uuidString
    var currencyName: String
    var currencyValue: Double
}

// You may modify this 
var currencies = ["USD", "AUD", "EUR", "INR", "JPY", "MYR"]
