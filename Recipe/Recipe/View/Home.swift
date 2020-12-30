//
//  Home.swift
//  Recipe
//
//  Created by Ginger on 30/12/2020.
//

import SwiftUI

struct Home: View {
    @State var search = ""
    @State var selectedTab = "Home"
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image("profile")
                            .renderingMode(.original)
                    }
                }
                .padding([.horizontal, .bottom])
                .padding(.top, 10)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack(spacing: 15) {
                            HStack(spacing: 10) {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.gray)
                                
                                TextField("Search Recipe", text: $search)
                            }
                            .padding()
                            .background(Color.black.opacity(0.06))
                            .cornerRadius(15)
                            
                            Button(action: {}) {
                                Image("filter")
                                    .renderingMode(.original)
                                    .padding()
                                    .background(Color("yellow").opacity(0.2))
                                    .cornerRadius(15)
                            }
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("Top Recipes")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                        }
                        .padding()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                ForEach(recipes, id: \.title) { recipe in
                                    RecipeCard(recipe: recipe)
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                ForEach(categories, id: \.self) { title in
                                    CategoryCard(title: title)
                                }
                            }
                            .padding()
                        }
                    }
                }
                
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            }
            .padding(.bottom, 100)
            
            VStack {
                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .background(Color.black.opacity(0.05).ignoresSafeArea(.all, edges: .all))
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
