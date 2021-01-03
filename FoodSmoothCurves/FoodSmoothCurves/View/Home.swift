//
//  Home.swift
//  FoodSmoothCurves
//
//  Created by Ginger on 03/01/2021.
//

import SwiftUI

struct Home: View {
    @State var search = ""
    @State var detail = false
    @State var isSmallDevice = UIScreen.main.bounds.height < 850
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("profile")
                            .renderingMode(.original)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 45, height: 45)
                    }
                }
                
                HStack(spacing: 10) {
                    Text("Top Choice")
                        .fontWeight(.heavy)
                        .foregroundColor(.gray)
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 14, weight: .heavy))
                        .foregroundColor(.gray)
                }
            }
            .padding([.horizontal, .top])
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    VStack(spacing: 10) {
                        HStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.black)
                            
                            TextField("Find something tasty", text: $search)
                        }
                        
                        Divider()
                    }
                    .padding(.horizontal)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Party Donut")
                                .font(isSmallDevice ? .title2 : .title)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            
                            Text("Everyone's favourite donut in new glaze")
                                .font(isSmallDevice ? .caption : .none)
                                .fontWeight(.heavy)
                                .foregroundColor(Color.black.opacity(0.6))
                            
                            Button(action: {
                                detail.toggle()
                            }) {
                                HStack(spacing: 10) {
                                    Text("Find out")
                                        .fontWeight(.heavy)
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .heavy))
                                }
                                .foregroundColor(.black)
                            }
                        }
                        .padding(.top, 30)
                        .padding(.leading)
                        
                        Image("donut")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 180)
                            .offset(x: 15, y: -15)
                    }
                    .padding()
                    .background(
                        Color("pink")
                            .cornerRadius(30)
                            .padding(.bottom, 30)
                            .padding(.top, 30)
                    )
                    .padding(.top)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 15), count: 2), spacing: 20) {
                        ForEach(items) { item in
                            ItemView(item: item)
                        }
                    }
                    .padding(.top, 10)
                }
                .padding()
            }
        }
        .fullScreenCover(isPresented: $detail) {
            DetailView()
        }
    }
}
