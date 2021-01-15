//
//  Home.swift
//  CurrencyExchange
//
//  Created by Ginger on 15/01/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var viewModel = FetchData()
    var body: some View {
        VStack {
            if viewModel.conversionData.isEmpty {
                ProgressView()
            } else {
                ScrollView {
                    // Fetched Data
                    LazyVStack(alignment: .leading, spacing: 15) {
                        ForEach(viewModel.conversionData) { rate in
                            HStack(spacing: 15) {
                                Text(getFlag(currency: rate.currencyName))
                                    .font(.system(size: 65))
                                
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(rate.currencyName)
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text("\(rate.currencyValue)")
                                        .fontWeight(.heavy)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.top)
                }
            }
        }
        .toolbar {
            Menu(content: {
                ForEach(currencies, id: \.self) { name in
                    Button(action: {
                        viewModel.updateData(base: name)
                    }) {
                        Text(name)
                    }
                }
            }) {
                Text("Base: \(viewModel.base)")
                    .fontWeight(.heavy)
            }
        }
    }
    
    // getting Country Flag By Currency Name
    func getFlag(currency: String) -> String {
        let base = 127397
        
        var code = currency
        code.removeLast()
        
        var scalar = String.UnicodeScalarView()
        
        for i in code.utf16 {
            scalar.append(UnicodeScalar(base + Int(i))!)
        }
        
        return String(scalar)
    }
}
