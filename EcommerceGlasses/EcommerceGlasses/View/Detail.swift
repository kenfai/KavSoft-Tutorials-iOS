//
//  Detail.swift
//  EcommerceGlasses
//
//  Created by Ginger on 28/01/2021.
//

import SwiftUI

struct Detail: View {
    @Binding var selectedItem: Item
    @Binding var show: Bool
    
    var animation: Namespace.ID
    
    @State var loadContent = false
    @State var selectedColor: Color = Color("p1")
    
    var body: some View {
        
        // optimisation for smaller size iPhone
        ScrollView(UIScreen.main.bounds.height < 750 ? .vertical : .init()) {
            VStack {
                HStack(spacing: 25) {
                    Button(action: {
                        withAnimation(.spring()) {
                            show.toggle()
                        }
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "bag")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                .padding()
                
                VStack(spacing: 10) {
                    Image(selectedItem.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        // since id is common
                        .matchedGeometryEffect(id: "image\(selectedItem.id)", in: animation)
                        .padding()
                    
                    Text(selectedItem.title)
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Text(selectedItem.subTitle)
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                    
                    HStack {
                        Text(selectedItem.rating)
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                            .matchedGeometryEffect(id: "rating\(selectedItem.id)", in: animation)
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "suit.heart")
                                .font(.title2)
                                .foregroundColor(.black)
                        }
                        .matchedGeometryEffect(id: "heart\(selectedItem.id)", in: animation)
                    }
                    .padding()
                }
                .padding(.top, 35)
                .background(Color(selectedItem.image)
                                .clipShape(CustomShape())
                                .matchedGeometryEffect(id: "color\(selectedItem.id)", in: animation))
                .cornerRadius(15)
                .padding()
                
                // delay loading the content for smooth animation
                VStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Exclusive Offer")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        HStack {
                            Text("Frame + Lens for $35")
                                .foregroundColor(.gray)
                            
                            Text("50% off!")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width - 30, alignment: .leading)
                    .background(Color("p3"))
                    .cornerRadius(15)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Color")
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                        
                        HStack(spacing: 15) {
                            ForEach(1...4, id: \.self) { i in
                                ZStack {
                                    Color("p\(i)")
                                        .clipShape(Circle())
                                        .frame(width: 45, height: 45)
                                        .onTapGesture {
                                            withAnimation {
                                                selectedColor = Color("p\(i)")
                                            }
                                        }
                                    
                                    // checkmark for selected one
                                    if selectedColor == Color("p\(i)") {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.black)
                                    }
                                }
                            }
                            
                            Spacer(minLength: 0)
                        }
                    }
                    .padding()
                    
                    Spacer(minLength: 15)
                    
                    Button(action: {}) {
                        Text("TRY FRAME IN 3D")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    }
                    
                    Button(action: {}) {
                        Text("ADD TO CART")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 100)
                            .background(Color.black)
                            .cornerRadius(15)
                    }
                    .padding(.vertical)
                }
                .padding([.horizontal, .bottom])
                .frame(height: loadContent ? nil : 0)
                .opacity(loadContent ? 1 : 0)
                // for smooth transition
                
                Spacer(minLength: 0)
            }
        }
        .onAppear {
            withAnimation(Animation.spring().delay(0.45)) {
                loadContent.toggle()
            }
        }
    }
}
