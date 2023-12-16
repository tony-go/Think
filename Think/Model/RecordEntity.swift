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
        
        record.id = UUID()
        record.emoji = "🔊"
        record.label = "Record"
        record.path = nil
        record.position = position
        record.fromSound = sound
        
        // TODO: use i18n
        RecordEntity.save(errorLog: "Error during record creation")
    }
}
