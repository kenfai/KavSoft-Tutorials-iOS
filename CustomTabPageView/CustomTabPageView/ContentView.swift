//
//  ContentView.swift
//  CustomTabPageView
//
//  Created by Ginger on 04/12/2020.
//

import SwiftUI

struct ContentView: View {
    @State private var tabIndex = 0
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $tabIndex) {
                    VStack {
                        Text("Home")
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.red)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(0)
                    
                    VStack {
                        Text("Favourite")
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.blue)
                    .tabItem {
                        Image(systemName: "heart.fill")
                        Text("Favourite")
                    }
                    .tag(1)
                    
                    VStack {
                        Text("Profile")
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.green)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                    .tag(2)
                    
                    VStack {
                        Text("Settings")
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.yellow)
                    .tabItem {
                        Image(systemName: "gear")
                            .font(.system(size: 30))
                        Text("Settings")
                    }
                    .tag(3)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Menu(content: {
                Button(action: {
                    withAnimation {
                        tabIndex = 0
                    }
                }) {
                    HStack {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                }
                
                Button(action: {
                    withAnimation {
                        tabIndex = 1
                    }
                }) {
                    HStack {
                        Image(systemName: "heart.fill")
                        Text("Favourite")
                    }
                }
            
                Button(action: {
                    withAnimation {
                        tabIndex = 2
                    }
                }) {
                    HStack {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
                }
            
                Button(action: {
                    withAnimation {
                        tabIndex = 3
                    }
                }) {
                    HStack {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                }
            }, label: {
                Image(systemName: "line.horizontal.3")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
