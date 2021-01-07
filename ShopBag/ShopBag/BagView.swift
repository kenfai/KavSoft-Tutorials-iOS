//
//  BagView.swift
//  ShopBag
//
//  Created by Ginger on 07/01/2021.
//

import SwiftUI

struct BagView: View {
    var bagData: BagModel
    var animation: Namespace.ID
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                Color(bagData.image)
                    .cornerRadius(15)
                
                Image(bagData.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(20)
                    .matchedGeometryEffect(id: bagData.image, in: animation)
            }
            
            Text(bagData.title)
                .fontWeight(.heavy)
                .foregroundColor(.gray)
            
            Text(bagData.price)
                .fontWeight(.heavy)
                .foregroundColor(.black)
        }
    }
}
