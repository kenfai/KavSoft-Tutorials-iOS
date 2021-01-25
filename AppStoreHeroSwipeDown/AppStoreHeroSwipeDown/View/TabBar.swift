//
//  TabBar.swift
//  AppStoreHeroSwipeDown
//
//  Created by Ginger on 25/01/2021.
//

import SwiftUI

struct TabBar: View {
    @Namespace var animation
    @StateObject var detailObject = DetailViewModel()
    
    var body: some View {
        ZStack {
            TabView {
                Today(animation: animation)
                    .environmentObject(detailObject)
                    .tabItem {
                        Image("today")
                            .renderingMode(.template)
                        
                        Text("Today")
                    }
                
                Text("Games")
                    .tabItem {
                        Image("games")
                            .renderingMode(.template)
                        Text("Games")
                    }
                
                Text("Apps")
                    .tabItem {
                        Image("apps")
                            .renderingMode(.template)
                        Text("Apps")
                    }
                Text("Search")
                    .tabItem {
                        Image("search")
                            .renderingMode(.template)
                        Text("Search")
                    }
            }
            // hiding tab bar when detail page opens
            .opacity(detailObject.show ? 0 : 1)
            
            if detailObject.show {
                Detail(detail: detailObject, animation: animation)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
