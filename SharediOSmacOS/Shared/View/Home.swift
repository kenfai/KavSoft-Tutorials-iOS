//
//  Home.swift
//  SharediOSmacOS (iOS)
//
//  Created by Ginger on 13/02/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = LoginViewModel()
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0) {
            VStack {
                HStack {
                    Text("Fitness You\nWanna Have")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.leading, 25)
                    
                    Spacer()
                }
                .padding()
                .overlay(
                    HStack {
                        Image("cloud")
                            .shadow(color: Color.black.opacity(0.09), radius: 5, x: 2, y: 5)
                            .offset(x: -85, y: 30)
                        
                        Spacer()
                        
                        VStack {
                            Image("cloud")
                                .shadow(color: Color.black.opacity(0.09), radius: 5, x: 2, y: 5)
                                .offset(x: 30)
                            
                            Spacer()
                        }
                    }, alignment: .bottomLeading
                )
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .padding(.horizontal)
                
                // Login / Register Page
                
                // Only for iOS
                if !homeData.ismacOS {
                    SideLoginView()
                }
            }
            
            // For macOS
            if homeData.ismacOS {
                SideLoginView()
            }
        }
        .frame(maxHeight: .infinity)
        .background((homeData.ismacOS ? nil : Color("bg"))
                        .ignoresSafeArea(.all, edges: .all))
        // Setting Frame only for macOS
        .frame(width: homeData.ismacOS ? homeData.screen.width / 2 : nil, height: homeData.ismacOS ? homeData.screen.height / 2 : nil)
        // Setting Environment Object as Home Data
        // So that it can be used in all sub Views
        // and eliminated redeclaration
        .environmentObject(homeData)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
