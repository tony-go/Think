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
        let inMemory = CommandLine.arguments.contains("testing")
        
        self.container = NSPersistentContainer(name: "Store")
        
        if inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.container.persistentStoreDescriptions = [description]
        }
        
        self.container.loadPersistentStores(completionHandler: { (_, err) in
            if let error = err {
                fatalError(error.localizedDescription)
            }
            print("loadPersistentStores")
        })
    }
    
    func save() {
        let viewContext = self.container.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}
