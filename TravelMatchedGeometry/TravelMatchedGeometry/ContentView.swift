//
//  ContentView.swift
//  TravelMatchedGeometry
//
//  Created by Ginger on 09/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

struct Home: View {
    var animation: Namespace.ID
    @Binding var show: Bool
    @Binding var selected: Model
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Text("Discover a \nDifferent World")
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .foregroundColor(Color("txt"))
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image("search")
                            .renderingMode(.template)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Color"))
                            .clipShape(Circle())
                    }
                }
                .padding()
                // since all edges are ignored
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(1...5, id: \.self) { i in
                            Image("r\(i)")
                                .renderingMode(.original)
                                .onTapGesture {
                                    // do some stuff
                                }
                        }
                    }
                    .padding()
                }
                
                HStack {
                    Text("Destinations")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("txt"))
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text("See All")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                
                ForEach(data) { travel in
                    ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                        Image("\(travel.img)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 300)
                            .cornerRadius(25)
                            .matchedGeometryEffect(id: travel.img, in: animation)
                        
                        VStack(alignment: .trailing, spacing: 8) {
                            Text(travel.title)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: travel.title, in: animation)
                            
                            Text(travel.country)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .matchedGeometryEffect(id: travel.country, in: animation)
                        }
                        .padding()
                    }
                    .padding()
                    // setting detail Data
                    .onTapGesture {
                        withAnimation(.spring()) {
                            selected = travel
                            show.toggle()
                        }
                    }
                }
            }
        }
    }
}

struct Liked: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("Liked")
            
            Spacer()
        }
    }
}

struct Account: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("Account")
            
            Spacer()
        }
    }
}

// Creating Tab Views
struct MainView: View {
    @State var tab = "Explore"
    @State var show = false
    @State var selected: Model = data[0]
    
    @Namespace var animation
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                // changing Views Based on tab
                switch(tab) {
                case "Explore": Home(animation: animation, show: $show, selected: $selected)
                case "Liked": Liked()
                default: Account()
                }
                
                Spacer()
                
                HStack(spacing: 0) {
                    tabButton(title: "Explore", tab: $tab)
                    
                    Spacer(minLength: 0)
                    
                    tabButton(title: "Liked", tab: $tab)
                    
                    Spacer(minLength: 0)
                    
                    tabButton(title: "Account", tab: $tab)
                }
                .padding(.top)
                // for smaller size iPhone
                .padding(.bottom, UIApplication.shared.windows.first!.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first!.safeAreaInsets.bottom)
                .padding(.horizontal, 35)
                .background(Color.white)
                .clipShape(RoundedShape(corners: [.topLeft, .topRight]))
            }
            
            // Detail View
            if show {
                Detail(selected: $selected, show: $show, animation: animation)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .background(Color("bg").edgesIgnoringSafeArea(.all))
    }
}

// Detail View
struct Detail: View {
    @Binding var selected: Model
    @Binding var show: Bool
    
    var animation: Namespace.ID
    
    var body: some View {
        VStack {
            VStack {
                ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                    Image(selected.img)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 330)
                        .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight]))
                        .matchedGeometryEffect(id: selected.img, in: animation)
                
                    HStack {
                        Button(action: {
                            withAnimation(.spring()) {
                                show.toggle()
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Image(systemName: "suit.heart")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        }
                    }
                    .padding()
                    // since all edges are ignored
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                }
                
                // Details View
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(selected.title)
                            .font(.title)
                            .foregroundColor(Color("txt"))
                            .fontWeight(.bold)
                            .matchedGeometryEffect(id: selected.title, in: animation)
                        
                        HStack(spacing: 10) {
                            Image("map")
                            
                            Text(selected.country)
                                .foregroundColor(.black)
                                .matchedGeometryEffect(id: selected.country, in: animation)
                            
                            HStack(spacing: 5) {
                                Text(selected.ratings)
                                    .foregroundColor(.black)
                                
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                    }
                    
                    Spacer(minLength: 0)
                    
                    Text(selected.price)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color("txt"))
                }
                .padding()
                .padding(.bottom)
            }
            .background(Color.white)
            .clipShape(RoundedShape(corners: [.bottomLeft, .bottomRight]))
            
            // ScrollView for Smaller size iPhones
            if UIScreen.main.bounds.height < 750 {
                ScrollView(.vertical, showsIndicators: false) {
                    BottomView()
                }
            } else {
                BottomView()
            }
            
            Spacer(minLength: 0)
        }
        .background(Color("bg"))
    }
}

struct BottomView: View {
    @State var index = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("People")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("txt"))
            
            Text("Member Of Your Group")
                .font(.caption)
            
            HStack(spacing: 15) {
                ForEach(1...6, id: \.self) { i in
                    Button(action: {
                        index = i
                    }) {
                        Text("\(i)")
                            .fontWeight(.bold)
                            .foregroundColor(index == i ? .white : .gray)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color("Color").opacity(index == i ? 1 : 0.07))
                            .cornerRadius(4)
                    }
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top)
            
            Text("Description")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color("txt"))
                .padding(.top, 10)
            
            Text("The Caribbean is a region of the Americas that consists of the Caribbean Sea, its islands (some surrounded by the Caribbean Sea and some bordering both the Caribbean Sea and the North Atlantic Ocean) and the surrounding coasts.")
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 0)
            
            HStack {
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    Text("Book Now")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 100)
                        .background(Color("Color"))
                        .clipShape(Capsule())
                }
                
                Spacer(minLength: 0)
            }
            .padding(.top)
            // since all edges are ignored
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom == 0 ? 15 : UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        }
        .padding([.horizontal, .top])
    }
}

// Tab buttons
struct tabButton: View {
    var title: String
    @Binding var tab: String
    
    var body: some View {
        Button(action: {
            tab = title
        }) {
            HStack(spacing: 8) {
                Image(title)
                    .renderingMode(.template)
                    .foregroundColor(tab == title ? .white: .gray)
                
                Text(tab == title ? title : "")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            .background(Color("Color").opacity(tab == title ? 1 : 0))
            .clipShape(Capsule())
        }
    }
}

// bottom only rounded corners
struct RoundedShape: Shape {
    // for reusable
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: 45, height: 45))
        
        return Path(path.cgPath)
    }
}

// Model and Sample Data
struct Model: Identifiable {
    var id = UUID().uuidString
    var title: String
    var country: String
    var ratings: String
    var price: String
    var img: String
}

var data = [
    Model(title: "Carribean", country: "French", ratings: "4.9", price: "$200", img: "p1"),
    Model(title: "Big Sur", country: "USA", ratings: "4.1", price: "$150", img: "p2")
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
