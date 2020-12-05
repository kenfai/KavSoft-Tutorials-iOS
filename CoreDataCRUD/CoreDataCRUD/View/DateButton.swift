//
//  DateButton.swift
//  CoreDataCRUD
//
//  Created by Ginger on 05/12/2020.
//

import SwiftUI

struct DateButton: View {
    var title: String
    @ObservedObject var homeData: HomeViewModel
    
    var body: some View {
        Button(action: {
            homeData.updateDate(value: title)
        }) {
            Text(title)
                .fontWeight(.bold)
                .foregroundColor(homeData.checkDate() == title ? .white : .gray)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(LinearGradient(gradient: Gradient(colors: homeData.checkDate() == title ? [Color("Color"), Color("Color1")] : [Color.white]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(6)
        }
    }
}
