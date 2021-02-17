//
//  SharedTabBarApp.swift
//  Shared
//
//  Created by Ginger on 17/02/2021.
//

import SwiftUI

@main
struct SharedTabBarApp: App {
    var body: some Scene {
        #if os(iOS)
        WindowGroup {
            ContentView()
        }
        #else
        WindowGroup {
            ContentView()
        }
        .windowStyle(HiddenTitleBarWindowStyle())
        #endif
    }
}
