//
//  ContentView.swift
//  FashionTranslucent
//
//  Created by Ginger on 29/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var search = ""
    @State var index = 0
    @State var tabIndex = 0
    
    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width)
            // Blurring the View
                .blur(radius: 35, opaque: true)
            
            VStack(spacing: 0) {
                //ScrollView
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        HStack {
                            Button(action: {}) {
                                Image("menu")
                                    .renderingMode(.original)
                            }
                            
                            Spacer()
                            
                            Image("pic")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        }
                        .padding(.all)
                        
                        HStack {
                            Text("Find Your\nFavourite Clothes")
                                .font(.system(size: 30))
                                .foregroundColor(.black)
                            
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 25) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                            
                            VStack(alignment: .leading) {
                                TextField("Search", text: $search)
                                
                                Divider()
                                    .background(Color.black)
                            }
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        
                        // Menu
                        
                        HStack(spacing: 15) {
                            ForEach(0..<menu.count, id: \.self) { i in
                                Button(action: {
                                    index = i
                                }) {
                                    VStack(spacing: 4) {
                                        Text(menu[i])
                                            .foregroundColor(.black)
                                            .fontWeight(index == i ? .bold : .none)
                                            .font(.system(size: 14))
                                        
                                        Circle()
                                            .fill(Color.black)
                                            .frame(width: 6, height: 6)
                                            .opacity(index == i ? 1 : 0)
                                    }
                                    .padding(.vertical)
                                }
                            }
                        }
                        .padding(.top, 10)
                        
                        // Row View
                        HStack(spacing: 15) {
                            VStack(alignment: .leading, spacing: 10) {
                                ZStack(alignment: .topLeading) {
                                    BlurView(style: .regular)
                                    
                                    Image("p1")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                    
                                    // Like Button
                                    VStack {
                                        HStack {
                                            Button(action: {}) {
                                                Image(systemName: "suit.heart.fill")
                                                    .foregroundColor(.red)
                                                    .padding(.all, 10)
                                                    .background(Color.white)
                                                    .clipShape(Circle())
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(.all, 10)
                                }
                                // dynamic frame
                                // padding 30 + spacing 15 = 45
                                .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 250)
                                .cornerRadius(15)
                                
                                Text("Summer Top")
                                    .font(.system(size: 14))
                                
                                Text("$129")
                                    .fontWeight(.bold)
                            }
                            
                            VStack(alignment: .leading, spacing: 10) {
                                ZStack(alignment: .topLeading) {
                                    BlurView(style: .regular)
                                    
                                    Image("p2")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .rotationEffect(Angle(degrees: 5))
                                    
                                    // Like Button
                                    VStack {
                                        HStack {
                                            Button(action: {}) {
                                                Image(systemName: "suit.heart.fill")
                                                    .foregroundColor(.red)
                                                    .padding(.all, 10)
                                                    .background(Color.white)
                                                    .clipShape(Circle())
                                            }
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(.all, 10)
                                }
                                // dynamic frame
                                // padding 30 + spacing 15 = 45
                                .frame(width: (UIScreen.main.bounds.width - 45) / 2, height: 250)
                                .cornerRadius(15)
                                
                                Text("Trend Top")
                                    .font(.system(size: 14))
                                
                                Text("$159")
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.all)
                        
                        HStack {
                            Text("New Collections")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, 10)
                        
                        ZStack(alignment: .topLeading) {
                            BlurView(style: .regular)
                            
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Casual Top")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                    
                                    Text("$299")
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                    
                                    Button(action: {}) {
                                        Text("Try Now")
                                            .foregroundColor(.black)
                                            .padding(.vertical, 10)
                                            .padding(.horizontal, 20)
                                            .background(Color.white)
                                            .clipShape(Capsule())
                                    }
                                    .padding(.top, 10)
                                }
                                .padding()
                                
                                Image("p3")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                            
                            // Like Button
                            VStack {
                                HStack {
                                    Button(action: {}) {
                                        Image(systemName: "suit.heart.fill")
                                            .foregroundColor(.red)
                                            .padding(.all, 10)
                                            .background(Color.white)
                                            .clipShape(Circle())
                                    }
                                }
                                
                                Spacer()
                            }
                            .padding(.all, 10)
                        }
                        .frame(height: 250)
                        .cornerRadius(15)
                        .padding(.all)
                        
                        Spacer()
                    }
                    // due to all edges are ignored
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding(.bottom)
                }
                
                // TabView
                HStack(spacing: 0) {
                    Button(action: {
                        tabIndex = 0
                    }) {
                        Image(systemName: "suit.heart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(tabIndex == 0 ? .white : Color("Color"))
                            .padding(.all)
                            .background(Color("Color").opacity(tabIndex == 0 ? 1 : 0))
                            .clipShape(Circle())
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        tabIndex = 1
                    }) {
                        Image(systemName: "house.fill")
                            .font(.system(size: 20))
                            .foregroundColor(tabIndex == 1 ? .white : Color("Color"))
                            .padding(.all)
                            .background(Color("Color").opacity(tabIndex == 1 ? 1 : 0))
                            .clipShape(Circle())
                    }
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {
                        tabIndex = 2
                    }) {
                        Image(systemName: "cart.fill")
                            .font(.system(size: 20))
                            .foregroundColor(tabIndex == 2 ? .white : Color("Color"))
                            .padding(.all)
                            .background(Color("Color").opacity(tabIndex == 2 ? 1 : 0))
                            .clipShape(Circle())
                    }
                }
                .padding(.top)
                .padding(.horizontal)
                // due to all edges are ignored
                .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
                .background(BlurView(style: .regular))
                .clipShape(CShape())
                // shadow
                .shadow(radius: 4)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

// Rounded Corners for separate Edges
struct CShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 35, height: 35))
        
        return Path(path.cgPath)
    }
}

var menu = ["New", "Popular", "Trending", "Highlights", "Medium"]

// Visual Effect View
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
