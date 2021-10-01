//
//  PersistenceController.swift
//  Think
//
//  Created by Tony Gorez on 01/10/2021.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Store")
        container.loadPersistentStores(completionHandler: { (description, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
            print("loadPersistentStores")
        })
    }
    
    func save() {
        let ctx = container.viewContext
        if ctx.hasChanges {
            do {
                try ctx.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
