//
//  JSONToCoreDataApp.swift
//  JSONToCoreData
//
//  Created by Ginger on 24/01/2021.
//

import SwiftUI

@main
struct JSONToCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
