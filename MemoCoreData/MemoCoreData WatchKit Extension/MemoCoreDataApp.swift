//
//  MemoCoreDataApp.swift
//  MemoCoreData WatchKit Extension
//
//  Created by Ginger on 27/02/2021.
//

import SwiftUI

@main
struct MemoCoreDataApp: App {
    let container = PersistenceController.shared.container
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
            .environment(\.managedObjectContext, container.viewContext)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
