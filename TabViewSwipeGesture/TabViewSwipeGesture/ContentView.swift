//
//  ContentView.swift
//  TabViewSwipeGesture
//
//  Created by Ginger on 16/11/2020.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home: View {
    @State var index = 0
    @State var selection = 0
    
    var body: some View {
        VStack {
            HStack {
                Text("STAT")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color"))
                
                Spacer(minLength: 0)
            }
            .padding(.horizontal)
            
            // Tab View
            HStack(spacing: 0) {
                Text("Day")
                    .foregroundColor(index == 0 ? .white : Color("Color").opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 35)
                    .background(Color("Color").opacity(index == 0 ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.default) {
                            index = 0
                            selection = 0
                        }
                    }
                
                Spacer(minLength: 0)
                
                Text("Week")
                    .foregroundColor(index == 1 ? .white : Color("Color").opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 35)
                    .background(Color("Color").opacity(index == 1 ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.default) {
                            index = 1
                            selection = 1
                        }
                    }
                
                Spacer(minLength: 0)
                
                Text("Month")
                    .foregroundColor(index == 2 ? .white : Color("Color").opacity(0.7))
                    .fontWeight(.bold)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 35)
                    .background(Color("Color").opacity(index == 2 ? 1 : 0))
                    .clipShape(Capsule())
                    .onTapGesture {
                        withAnimation(.default) {
                            index = 2
                            selection = 2
                        }
                    }
            }
            .background(Color.black.opacity(0.06))
            .clipShape(Capsule())
            .padding(.horizontal)
            .padding(.top, 25)
            
                // Dashboard Grid
            // Tab View With Swipe Gestures
            // connecting index with TabView for Tab Change
            TabView(selection: $selection) {
                // week data
                GridView(fitness_Data: fit_Data)
                    .tag(0)
                
                // month data
                GridView(fitness_Data: week_Fit_Data)
                    .tag(1)
                
                VStack {
                    Text("Monthly Data")
                }
                .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: selection) { s in
                withAnimation {
                    index = s
                }
            }
            
            Spacer(minLength: 0)
        }
        .padding(.top)
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Grid View
struct GridView: View {
    var fitness_Data: [Fitness]
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 30) {
            ForEach(fitness_Data) { fitness in
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)) {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(fitness.title)
                            .foregroundColor(.white)
                        
                        Text(fitness.data)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        
                        HStack {
                            Spacer(minLength: 0)
                            
                            Text(fitness.suggest)
                                .foregroundColor(.white)
                        }
                    }
                    .padding()
                    .frame(maxHeight: 180)
                    // image name same as color name
                    .background(Color(fitness.image))
                    .cornerRadius(20)
                    // shadow
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    
                    // Top image
                    Image(fitness.image)
                        .renderingMode(.template)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white.opacity(0.12))
                        .clipShape(Circle())
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 25)
    }
}

// Dashboard Grid Model Data
struct Fitness: Identifiable {
    var id: Int
    var title: String
    var image: String
    var data: String
    var suggest: String
}


// Daily Data
var fit_Data = [

    Fitness(id: 0, title: "Heart Rate", image: "heart", data: "124 bpm", suggest: "80-120\nHealthy"),

    Fitness(id: 1, title: "Sleep", image: "sleep", data: "6h 43m", suggest: "Deep Sleep\n5h 13m"),
    
    Fitness(id: 2, title: "Energy Burn", image: "energy", data: "583 kcal", suggest: "Daily Goal\n900 kcal"),
            
    Fitness(id: 3, title: "Steps", image: "steps", data: "16,741", suggest: "Daily Goal\n20,000 Steps"),
    
    Fitness(id: 4, title: "Running", image: "running", data: "5.3 km", suggest: "Daily Goal\n10 km"),
    
    Fitness(id: 5, title: "Cycling", image: "cycle", data: "15.3 km", suggest: "Daily Goal\n20 km"),
]

// Monthly Data
var week_Fit_Data = [

    Fitness(id: 0, title: "Heart Rate", image: "heart", data: "84 bpm", suggest: "80-120\nHealthy"),

    Fitness(id: 1, title: "Sleep", image: "sleep", data: "43h 23m", suggest: "Deep Sleep\n26h 13m"),
    
    Fitness(id: 2, title: "Energy Burn", image: "energy", data: "3,500 kcal", suggest: "Weekly Goal\n4,800 kcal"),
            
    Fitness(id: 3, title: "Steps", image: "steps", data: "17,8741", suggest: "Weekly Goal\n25,0000 Steps"),
    
    Fitness(id: 4, title: "Running", image: "running", data: "45.3 km", suggest: "Weekly Goal\n70 km"),
    
    Fitness(id: 5, title: "Cycling", image: "cycle", data: "100.3 km", suggest: "Weekly Goal\n125 km"),
]


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
