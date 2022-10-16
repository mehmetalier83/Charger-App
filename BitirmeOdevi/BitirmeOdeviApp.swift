//
//  BitirmeOdeviApp.swift
//  BitirmeOdevi
//
//  Created by PRO10010 on 16.10.2022.
//

import SwiftUI

@main
struct BitirmeOdeviApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
