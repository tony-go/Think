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
    
    static private func save(errorLog: String) {
        do {
            try RecordEntity.context.save()
            print("Records saved!")
        } catch let error {
            print("\(errorLog): \(error)")
        }
    }
    
    static func create(at position: Int32, in sound: Sound) {
        let record = Record(context: RecordEntity.context)
        
        // TODO: how to link to the current sound
        
        record.id = UUID()
        record.emoji = "🔊"
        record.label = "Record"
        record.path = nil
        record.position = position
        record.fromSound = sound
        
        // TODO: use i18n
        RecordEntity.save(errorLog: "Error during record creation")
    }
    
//    static func fetchRecord(for sound: Sound) -> [Record] {
//        let request: NSFetchRequest<Record> = Record.fetchRequest()
//        let predicate = NSPredicate(format: "fromSound == %@", sound)
//
//        request.predicate = predicate
//
//        do {
//            var records = try RecordEntity.context.fetch(request)
//            print("Record fetched for \(String(describing: sound.id?.uuidString))")
//            return records
//        } catch let error as NSError {
//            print("Could not fetch records: \(error), \(error.userInfo)")
//            return []
//        }
//
//    }
}
