//
//  Record.swift
//  Think
//
//  Created by Tony Gorez on 29/07/2021.
//

import Foundation

class RecordObject: ObservableObject {
    let title: String
    let description: String
    var id = UUID()
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
