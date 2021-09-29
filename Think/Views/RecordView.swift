//
//  RecordView.swift
//  Think
//
//  Created by Tony Gorez on 16/07/2021.
//

import SwiftUI

struct RecordView: View {
    let record: Record
    
    @State private var title = ""
    @State private var description = ""
    
    init(record: Record) {
        self.record = record
        self.title = record.title
    }
    
    var body: some View {
        Form {
            // TODO: add trad key
            Text("Your memo")
            TextField("Title", text: $title)
            TextField("Description", text: $description)
            Button("Save memo") {
                // TODO
            }.foregroundColor(.blue)
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(record: Record(title: "Hello", description: "lol"))
    }
}
