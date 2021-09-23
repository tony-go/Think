//
//  ListView.swift
//  Think
//
//  Created by Tony Gorez on 09/07/2021.
//

import SwiftUI

struct ListView: View {
    var records: [Record] = [Record(title: "Hello", description: "lol"), Record(title: "Salut Ous", description: "Llol 2")]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.accentColor
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    Header( // TODO: add trad here!
                        title: "Yodur audios",
                        subtitle: "Select one to edit it.",
                        action: {}
                    )
                    
                    VStack {
                        ForEach(records, id: \.self.id) { record in
                            NavigationLink(
                                destination: RecordView(record: record),
                                label: {
                                    RecordItem(title: record.title, action: {})
                                })
                        }
                    }
                }
            }.navigationBarBackButtonHidden(/*@START_MENU_TOKEN@*/false/*@END_MENU_TOKEN@*/)
            // TODO: white color for back button
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        // ListView()
    }
}
