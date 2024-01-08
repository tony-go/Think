//
//  RecordEntity.swift
//  Think
//
//  Created by Tony Gorez on 14/12/2023.
//

import Foundation
import CoreData

class RecordEntity {
    static var context = PersistenceController.shared.container.viewContext;
    
    static private func getOne(by id: UUID) -> Optional<Record> {
        let request: NSFetchRequest<Record> = Record.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        guard let record = try? RecordEntity.context.fetch(request) else {
            return nil
        }
        
        return record[0]
    }
    
    static func save(errorLog: String) {
        do {
            try RecordEntity.context.save()
            print("Records saved!")
        } catch let error {
            print("\(errorLog): \(error)")
        }
    }
    
    static func create(at position: Int32, in sound: Sound) {
        let record = Record(context: RecordEntity.context)
        
        record.id = UUID()
        record.emoji = "🔊"
        record.label = "Record \(position)"
        record.path = nil
        record.position = position
        record.fromSound = sound
        
        // TODO: use i18n
        RecordEntity.save(errorLog: "Error during record creation")
    }
    
    static func delete(by id: UUID) -> Optional<UUID> {
        if let record = RecordEntity.getOne(by: id) {
            RecordEntity.context.delete(record)

            return id
        }
        
        return nil
    }
}
