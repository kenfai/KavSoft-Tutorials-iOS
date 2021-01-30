//
//  Home.swift
//  SwipeToAction
//
//  Created by Ginger on 30/01/2021.
//

import SwiftUI

struct Home: View {
    @State var size = "Medium"
    @State var currentTab = "All"

    @State var items = [
        Item(title: "Stylish Table Lamp", price: "$20.00", subTitle: "We have amazing quality Lamp wide range.", image: "lamp"),
        Item(title: "Modern Chair", price: "$60.00", subTitle: "New style of tables for your home and office.", image: "chair"),
        Item(title: "Wodden Stool", price: "$35.00", subTitle: "Amazing Stylish in multiple Most selling item of this.", image: "stool"),
    ]

    @GestureState var isDragging = false
    
    // adding cart items
    
    @State var cart: [Item] = []
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {}) {
                    Image(systemName: "line.horizontal.3.decrease")
                        .font(.title)
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(.black)
                }
                .overlay(
                    // Cart Count
                    Text("\(cart.count)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .frame(width: 20, height: 20)
                        .background(Color("tab"))
                        .clipShape(Circle())
                        .offset(x: 15, y: -22)
                    // disabling if no items
                        .opacity(cart.isEmpty ? 0 : 1)
                )
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 10)
            
            ScrollView {
                VStack {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Furniture in \nUnique Style")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.black)
                            
                            Text("WE have wide range of furnitures")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .fontWeight(.bold)
                        }
                        
                        Spacer(minLength: 15)
                        
                        // Menu Button
                        Menu {
                            Button(action: {
                                size = "Small"
                            }) {
                                Text("Small")
                            }
                            
                            Button(action: {
                                size = "Medium"
                            }) {
                                Text("Medium")
                            }
                            
                            Button(action: {
                                size = "Large"
                            }) {
                                Text("Large")
                            }
                        } label: {
                            Label(title: {
                                Text(size)
                                .foregroundColor(.white)
                            }) {
                                Image(systemName: "slider.vertical.3")
                                .foregroundColor(.white)
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black)
                            .clipShape(Capsule())
                        }
                    }
                    .padding()
                    
                    ForEach(items.indices) { index in
                        // CardView
                        ZStack {
                            Color("tab")
                                .cornerRadius(20)
                            
                            Color("Color")
                                .cornerRadius(20)
                                .padding(.trailing, 65)
                            
                            // Button
                            HStack {
                                Spacer()
                                
                                Button(action: {}) {
                                    Image(systemName: "suit.heart")
                                        .font(.title)
                                        .foregroundColor(.white)
                                    // default frame
                                        .frame(width: 65)
                                }
                                
                                Button(action: {
                                    addCart(index: index)
                                }) {
                                    // changing cart image
                                    Image(systemName: checkCart(index: index) ? "cart.badge.minus" : "cart.badge.plus")
                                        .font(.title)
                                        .foregroundColor(.white)
                                        // default frame
                                        .frame(width: 65)
                                }
                            }
                            
                            CardView(item: items[index])
                            // drag gesture
                                .offset(x: items[index].offset)
                                .gesture(
                                    DragGesture()
                                        .updating($isDragging, body: { (value, state, _) in
                                            // so we can validate for correct drag
                                            state = true
                                            onChanged(value: value, index: index)
                                        }).onEnded({ (value) in
                                            onEnd(value: value, index: index)
                                        })
                                )
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                }
                .padding(.bottom, 100)
            }
        }
    }
    
    // checking cart and adding item
    func checkCart(index: Int) -> Bool {
        return cart.contains { item -> Bool in
            return item.id == items[index].id
        }
    }
    
    func addCart(index: Int) {
        if checkCart(index: index) {
            cart.removeAll { item -> Bool in
                return item.id == items[index].id
            }
        } else {
            cart.append(items[index])
        }
        
        // closing after added
        withAnimation {
            items[index].offset = 0
        }
    }
    
    func onChanged(value: DragGesture.Value, index: Int) {
        if value.translation.width < 0 && isDragging {
            items[index].offset = value.translation.width
        }
    }
    
    // onEnd is not working properly
    // maybe it's a bug
    // to avoid this we using update property on DragGesture
    func onEnd(value: DragGesture.Value, index: Int) {
        withAnimation {
            // 65 + 65 = 130
            if -value.translation.width >= 100 {
                items[index].offset = -130
            } else {
                items[index].offset = 0
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
