//
//  RecordView.swift
//  Think
//
//  Created by Tony Gorez on 16/07/2021.
//

import SwiftUI

struct RecordView: View {
    let record: Record
    
    var body: some View {
        Text(self.record.title)
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(record: Record(title: "Hello", description: "lol"))
    }
}
