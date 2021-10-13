//
//  Record.swift
//  Think
//
//  Created by Tony Gorez on 29/07/2021.
//

import Foundation
import CoreData

class SoundEntity: ObservableObject {
    @Published var sounds: [Sound] = []
    
    init() {
        self.fetchSounds()
    }
    
    func fetchSounds () {
        let request: NSFetchRequest<Sound> = Sound.fetchRequest()
        
        do {
            self.sounds = try SoundEntity.context.fetch(request)
        } catch let error {
            print("Error during fetching sound: \(error)")
        }
    }
    
    static let context = PersistenceController.shared.container.viewContext
    
    static func getRecord(id: UUID) -> Optional<Sound> {
        let request: NSFetchRequest<Sound> = Sound.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let sound = try? SoundEntity.context.fetch(request) else {
            return nil
        }
        
        return sound[0]
    }
    
    func update(
        id: UUID,
        newTitle: String,
        newDescription: String
    ) {
        if let sound = SoundEntity.getRecord(id: id) {
            sound.title = newTitle
            sound.desc = newDescription
            sound.updatedAt = Date()
            
            do {
                try SoundEntity.context.save()
            } catch let error {
                print("Error durin update sound: \(error)")
            }
            
            self.fetchSounds()
        
        }
        
    }
    
    func delete(by id: UUID) -> Optional<UUID> {
        if let sound = SoundEntity.getRecord(id: id) {
            SoundEntity.context.delete(sound)
            
            self.fetchSounds()

            return id
        }
        
        return nil
    }
    
    func create(title: String, description: String) {
        let sound = Sound(context: SoundEntity.context)
        sound.title = title
        sound.desc = description
        sound.id = UUID()
        sound.createdAt = Date()
        sound.updatedAt = Date()
        
        do {
            try SoundEntity.context.save()
        } catch let error {
            print("Error during sound creation: \(error)")
        }
        
        self.fetchSounds()
        
    }
}
