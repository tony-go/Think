//
//  Record.swift
//  Think
//
//  Created by Tony Gorez on 29/07/2021.
//

import Foundation
import CoreData

class SoundEntity {
    static let context = PersistenceController.shared.container.viewContext
    
    static private func getOne(by id: UUID) -> Optional<Sound> {
        let request: NSFetchRequest<Sound> = Sound.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let sound = try? SoundEntity.context.fetch(request) else {
            return nil
        }
        
        return sound[0]
    }
    
    static private func save(errorLog: String) {
        do {
            try SoundEntity.context.save()
        } catch let error {
            print("\(errorLog): \(error)")
        }
    }
    
    static func update(
        id: UUID,
        newTitle: String,
        newDescription: String
    ) {
        if let sound = SoundEntity.getOne(by: id) {
            sound.title = newTitle
            sound.desc = newDescription
            sound.updatedAt = Date()
            
            SoundEntity.save(errorLog: "Error during sound update")
        }
        
    }
    
    static func delete(by id: UUID) -> Optional<UUID> {
        if let sound = SoundEntity.getOne(by: id) {
            SoundEntity.context.delete(sound)

            return id
        }
        
        return nil
    }
    
    static func create(title: String, description: String) {
        let sound = Sound(context: SoundEntity.context)
        sound.title = title
        sound.desc = description
        sound.id = UUID()
        sound.createdAt = Date()
        sound.updatedAt = Date()
        
        SoundEntity.save(errorLog: "Error during sound creation")
    }
}
