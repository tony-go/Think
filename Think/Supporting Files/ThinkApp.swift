//
//  ThinkApp.swift
//  Think
//
//  Created by Tony Gorez on 09/07/2021.
//

import SwiftUI

@main
struct ThinkApp: App {
    let persistenceController = PersistenceController.shared
    
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase, perform: { (phase) in
            switch phase {
            case .background:
                persistenceController.save()
            case .inactive:
                print("Scene inactive")
            case .active:
                print("Scene active")
            @unknown default:
                print("Scene default")
            }
        })
    }
}

