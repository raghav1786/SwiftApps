//
//  UserPIApp.swift
//  UserPI
//
//  Created by RAGHAV SHARMA on 14/05/22.
//

import SwiftUI

@main
struct UserPIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
           return  ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
