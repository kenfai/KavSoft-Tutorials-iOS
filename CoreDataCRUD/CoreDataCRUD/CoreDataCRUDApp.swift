//
//  CoreDataCRUDApp.swift
//  CoreDataCRUD
//
//  Created by Ginger on 05/12/2020.
//

import SwiftUI

@main
struct CoreDataCRUDApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
