//
//  FirebaseGlobalChatApp.swift
//  FirebaseGlobalChat
//
//  Created by Ginger on 29/12/2020.
//

import SwiftUI
import Firebase

@main
struct FirebaseGlobalChatApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}
