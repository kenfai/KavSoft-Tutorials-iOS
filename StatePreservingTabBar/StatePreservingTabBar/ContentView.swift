//
//  ContentView.swift
//  StatePreservingTabBar
//
//  Created by Ginger on 26/12/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //NavigationView {
            Home()
        //}
    }
}

struct Home: View {
    @State var selectedTab = "Home"
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @Namespace var animation
    @StateObject var modelData = ModelView()
    
    var body: some View {
        VStack(spacing: 0) {
            //GeometryReader { _ in
                ZStack {
                    // Tabs
                    NavigationView {
                        ScrollView {
                            ForEach(1...25, id: \.self) { i in
                                NavigationLink(destination: Text("Home Data \(i)")) {
                                    VStack(alignment: .leading) {
                                        Text("Home Data \(i)")
                                            .padding()
                                            .foregroundColor(.black)
                                        
                                        Divider()
                                    }
                                }
                            }
                            .padding(.bottom)
                        }
                        .navigationBarHidden(true)
                    }
                    .opacity(selectedTab == "Home" ? 1 : 0)
                    
                    Text("Restaurants")
                        .opacity(selectedTab == "Restaurants" ? 1 : 0)
                    
                    Text("Orders")
                        .opacity(selectedTab == "Orders" ? 1 : 0)
                    
                    Text("Rewards")
                        .opacity(selectedTab == "Rewards" ? 1 : 0)
                }
            //}
            .onChange(of: selectedTab) { (_) in
                switch(selectedTab) {
                    case "Orders": if !modelData.isOrderLoad { modelData.loadOrders() }
                    case "Restaurants": if !modelData.isRestaurantLoad { modelData.loadRestaurants() }
                    case "Rewards": if !modelData.isRewardLoad { modelData.loadReward() }
                    default: ()
                }
            }
            
            // TabView
            HStack(spacing: 0) {
                ForEach(tabs, id: \.self) { tab in
                    TabButton(title: tab, selectedTab: $selectedTab, animation: animation)
                    
                    if tab != tabs.last {
                        Spacer(minLength: 0)
                    }
                }
            }
            .padding(.horizontal, 30)
            // for iPhone like 8 and SE
            .padding(.bottom, edges!.bottom == 0 ? 15 : edges!.bottom)
            .background(Color.white)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
    }
}

// Tab Button
struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedTab = title
            }
        }) {
            VStack(spacing: 6) {
                
                // Top indicator
                
                // Slide in and out Animation
                ZStack {
                    // Custom Shape
                    CustomShape()
                        .fill(Color.clear) // placeholder shape
                        .frame(width: 45, height: 6)
                    
                    if selectedTab == title {
                        CustomShape()
                            .fill(Color("tint"))
                            .frame(width: 45, height: 6)
                            .matchedGeometryEffect(id: "Tab_Change", in: animation)
                    }
                }
                .padding(.bottom, 10)
                
                Image(title)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(selectedTab == title ? Color("tint") : Color.black.opacity(0.2))
                    .frame(width: 24, height: 24)
                
                Text(title)
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black.opacity(selectedTab == title ? 0.6 : 0.2))
            }
        }
    }
}

// Custom Shape
struct CustomShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        
        return Path(path.cgPath)
    }
}

// Both title image name are same
var tabs = ["Home", "Restaurants", "Orders", "Rewards"]

// If you simply having Views and not that much network task means its fine
// otherwise, use this method to load data when the tab opens
class ModelView: ObservableObject {
    @Published var isOrderLoad = false
    @Published var isRestaurantLoad = false
    @Published var isRewardLoad = false
    
    init() {
        // load initial data
        print("Home Data Loaded")
    }
    
    func loadOrders() {
        print("order Loaded")
        isOrderLoad = true
    }
    
    func loadRestaurants() {
        print("Restaurant Loaded")
        isRestaurantLoad = true
    }
    
    func loadReward() {
        print("Reward Loaded")
        isRewardLoad = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
