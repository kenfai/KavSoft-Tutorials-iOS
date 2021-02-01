//
//  CardView.swift
//  NavigationSearchBar
//
//  Created by Ginger on 01/02/2021.
//

import SwiftUI

struct CardView: View {
    var item: AppItem
    @State var show = false

    var body: some View {
        HStack(spacing: 15) {
            Image(item.name)
                .resizable()
                .frame(width: 65, height: 65)
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(item.name)
                            .font(.title2)
                        
                        Text(item.source)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer(minLength: 10)
                    
                    VStack {
                        Button(action: {
                            show.toggle()
                        }) {
                            Text(show ? "Open" : "GET")
                                .fontWeight(.heavy)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 20)
                                .background(Color.primary.opacity(0.1))
                                .clipShape(Capsule())
                        }
                        
                        Text("In App Purchases")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                
                Divider()
            }
        }
        .padding(.horizontal)
    }
}
