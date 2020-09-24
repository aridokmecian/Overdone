//
//  twodoApp.swift
//  twodo
//
//  Created by Ari Dokmecian on 2020-09-23.
//

import SwiftUI

@main
struct twodoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
