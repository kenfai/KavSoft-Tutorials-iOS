//
//  ContentView.swift
//  TravelHeroAnimation
//
//  Created by Ginger on 20/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .edgesIgnoringSafeArea(.top)
    }
}

struct Home: View {
    var columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
    @State var selected: Travel = data[0]
    @State var show = false
    // to load Hero View After Animation is done
    @State var loadView = false
    
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                HStack {
                    Text("Travel")
                        .font(.system(size: 35, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("menu")
                            .renderingMode(.original)
                    }
                }
                // due to top area is ignored
                .padding([.horizontal, .top])
                
                // Grid View
                LazyVGrid(columns: columns, spacing: 25) {
                    ForEach(data) { travel in
                        VStack(alignment: .leading, spacing: 10) {
                            Image(travel.image)
                                .resizable()
                                .frame(height: 180)
                                .cornerRadius(15)
                                // assigning ID
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        show.toggle()
                                        selected = travel
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            loadView.toggle()
                                        }
                                    }
                                }
                                .matchedGeometryEffect(id: travel.id, in: namespace)
                            
                            Text(travel.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            
            // Hero View
            if show {
                VStack {
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                        Image(selected.image)
                            .resizable()
                            .frame(height: 300)
                            .matchedGeometryEffect(id: selected.id, in: namespace)
                        
                        if loadView {
                            HStack {
                                Button(action: {
                                    loadView.toggle()
                                    
                                    withAnimation(.spring()) {
                                        show.toggle()
                                    }
                                }) {
                                    Image(systemName: "xmark")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.black.opacity(0.5))
                                        .clipShape(Circle())
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                }) {
                                    Image(systemName: "suit.heart.fill")
                                        .foregroundColor(.red)
                                        .padding()
                                        .background(Color.white)
                                        .clipShape(Circle())
                                }
                            }
                            .padding(.top, 35)
                            .padding(.horizontal)
                        }
                    }
                    
                    // Detail View
                    ScrollView(.vertical, showsIndicators: false) {
                        // loading after animation
                        if loadView {
                            VStack {
                                HStack {
                                    Text(selected.title)
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                Text("Australia is the oldest, flattest, and driest inhabited continent, with the least fertile soils. It has a landmass of 7,617,930 square kilometres (2,941,300 sq mi). A megadiverse country, its size gives it a wide variety of landscapes, with deserts in the centre, tropical rainforests in the north-east, and mountain ranges in the south-east. Australia generates its income from various sources, including mining-related exports, telecommunications, banking, manufacturing, and international education.")
                                    .multilineTextAlignment(.leading)
                                    .padding(.top)
                                    .padding(.horizontal)
                                
                                HStack {
                                    Text("Reviews")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                HStack(spacing: 0) {
                                    ForEach(1...5, id: \.self) { i in
                                        Image("r\(i)")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50)
                                            .clipShape(Circle())
                                            .offset(x: -CGFloat(i * 20))
                                    }
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {}) {
                                        Text("View All")
                                            .fontWeight(.bold)
                                    }
                                }
                                // since first is moved -20
                                .padding(.leading, 20)
                                .padding(.top)
                                .padding(.horizontal)
                                
                                // Carousel
                                HStack {
                                    Text("Other Places")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                
                                    Spacer()
                                }
                                .padding(.top)
                                .padding(.horizontal)
                                
                                TabView {
                                    ForEach(1...6, id: \.self) { i in
                                        // ignoring the current Hero Image
                                        if "p\(i)" != selected.image {
                                            Image("p\(i)")
                                                .resizable()
                                                .cornerRadius(15)
                                                .padding(.horizontal)
                                        }
                                    }
                                }
                                .frame(height: 250)
                                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                .padding(.top)
                                
                                // Button
                                Button(action: {}) {
                                    Text("Book Trip")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 150)
                                        .background(Color.blue)
                                        .cornerRadius(15)
                                }
                                .padding(.top, 25)
                            }
                        }
                    }
                }
                .background(Color.white)
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
        // hide only for Hero View
        .statusBar(hidden: show)
    }
}

// Sample Data
struct Travel: Identifiable {
    var id: Int
    var image: String
    var title: String
}

var data = [
    Travel(id: 0, image: "p1", title: "London"),
    Travel(id: 1, image: "p2", title: "USA"),
    Travel(id: 2, image: "p3", title: "Canada"),
    Travel(id: 3, image: "p4", title: "Australia"),
    Travel(id: 4, image: "p5", title: "Germany"),
    Travel(id: 5, image: "p6", title: "Dubai"),
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
