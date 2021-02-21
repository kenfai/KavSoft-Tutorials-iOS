//
//  Catalogue.swift
//  NavigationDrawer
//
//  Created by Ginger on 21/02/2021.
//

import SwiftUI

struct Catalogue: View {
    @Environment(\.colorScheme) var scheme

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack(alignment: .leading, spacing: 15, content: {
                        Image("homepod")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 250, height: 250)
                            .offset(x: -20, y: -10)
                        
                        Text("Apple HomePod")
                            .font(.title2)
                            .fontWeight(.heavy)
                            .foregroundColor(.primary)
                        
                        Text("Great Music with Affordable Price!")
                            .foregroundColor(.gray)
                    })
                    .padding(.bottom, 55)
                    .padding(.leading, 7)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        Color.primary.opacity(0.06)
                            .cornerRadius(20)
                            .padding(.top, 70)
                    )
                    .offset(x: 70)
                    .overlay(
                        Button(action: {}, label: {
                            Image(systemName: "bag.fill")
                                .font(.title)
                            // For Dark Mode Adoption
                                .foregroundColor(scheme == .dark ? .black : .white)
                                .padding(20)
                                .background(Color.primary)
                                .cornerRadius(15)
                        })
                        .offset(x: -30, y: 35)
                        , alignment: .bottomTrailing
                    )
                    .padding(.vertical, 35)
                    
                    // CardView
                    CardView(image: "google", title: "Google Home")
                        .padding(.top, 25)
                    
                    CardView(image: "alexa", title: "Alexa")
                }
            }
            .navigationTitle("Catalogue")
        }
    }
}

struct Catalogue_Previews: PreviewProvider {
    static var previews: some View {
        Catalogue()
    }
}
