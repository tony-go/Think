//
//  Record.swift
//  Think
//
//  Created by Tony Gorez on 29/07/2021.
//

import Foundation
import CoreData

class SoundEntity: NSManagedObject {
    static let context = PersistenceController.shared.container.viewContext
    
//    static func getRecords() -> [Sound] {
//        let request: NSFetchRequest<Sound> = Sound.fetchRequest()
//
//        guard let sounds = try? SoundEntity.context.fetch(request) else {
//            return []
//        }
//
//        return sounds
//    }
    
//    static func getRecord(id: UUID) -> Optional<Sound> {
//        let request: NSFetchRequest<Sound> = Sound.fetchRequest()
//        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
//        
//        guard let sound = try? SoundEntity.context.fetch(request) else {
//            return nil
//        }
//        
//        return sound[0]
//    }
    
    static func saveRecord(
        id: UUID,
        newTitle: String,
        newDescription: String
    ) -> Optional<Sound> {
        let request: NSFetchRequest<Sound> = Sound.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let sounds = try? SoundEntity.context.fetch(request) else {
            return nil
        }
        
        let sound = sounds[0]
        sound.title = newTitle
        sound.desc = newDescription
        sound.updatedAt = Date()
        
        do {
            try SoundEntity.context.save()
        } catch {
            return nil
        }
        
        return sound
    }
}
