//
//  TabBar.swift
//  SwipeToAction
//
//  Created by Ginger on 30/01/2021.
//

import SwiftUI

struct TabBar: View {
    @State var current = "Home"

    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            TabView(selection: $current) {
                Home()
                    .tag("Home")
                
                Text("Messages")
                    .tag("Messages")
                
                Text("Account")
                    .tag("Account")
            }
            
            HStack(spacing: 0) {
                // TabButton
                TabButton(title: "Home", image: "home", selected: $current)
                
                Spacer(minLength: 0)
                
                TabButton(title: "Messages", image: "messenger", selected: $current)
                
                Spacer(minLength: 0)
                
                TabButton(title: "Account", image: "user", selected: $current)
            }
            .padding(.vertical, 12)
            .padding(.horizontal)
            .background(Color("tab"))
            .clipShape(Capsule())
            .padding(.horizontal, 25)
        }
    }
}

var tabs = ["Tables", "Chairs", "Lamps", "All"]

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
