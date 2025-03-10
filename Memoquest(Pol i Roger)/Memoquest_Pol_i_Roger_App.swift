//
//  Memoquest_Pol_i_Roger_App.swift
//  Memoquest(Pol i Roger)
//
//  Created by roger_jove on 10/3/25.
//

import SwiftUI

@main
struct Memoquest_Pol_i_Roger_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
