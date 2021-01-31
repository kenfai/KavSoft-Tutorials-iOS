//
//  QuizFirebaseFirestoreApp.swift
//  QuizFirebaseFirestore
//
//  Created by Ginger on 31/01/2021.
//

import SwiftUI
import Firebase

@main
struct QuizFirebaseFirestoreApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Initializing Firebase
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
