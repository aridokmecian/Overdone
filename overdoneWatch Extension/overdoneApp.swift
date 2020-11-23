//
//  overdoneApp.swift
//  overdoneWatch Extension
//
//  Created by Ari Dokmecian on 2020-11-22.
//

import SwiftUI

@main
struct overdoneApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
