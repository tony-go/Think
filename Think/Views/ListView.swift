//
//  ListView.swift
//  Think
//
//  Created by Tony Gorez on 09/07/2021.
//

import SwiftUI

struct CreationForm: View {
    var actionSave: () -> Void
    @State private var title = ""
    @State private var description = ""
    
    func onSave() {
        self.actionSave()
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("recordView.creationModal.formLabel")) {
                    TextField("recordView.creationModal.titlePlaceholder", text: $title)
                    TextField("recordView.creationModal.descriptionPlaceholder", text: $description)
                }
            }
            Spacer()
            Button(action: actionSave, label: {
                Text("recordView.creationModal.saveButtonLabel")
            }).foregroundColor(.purple)
        }
        // Bad practice ?
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

struct ListView: View {
    // fake records for testing
    var records: [RecordObject] = [RecordObject(title: "Hello", description: "lol"), RecordObject(title: "Salut Ous", description: "Llol 2")]
    
    @State var isModalPresented = false
    
    func openModal() {
        self.isModalPresented = true
    }
    
    func closeModal() {
        self.isModalPresented = false
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    Header( // TODO: add trad here!
                        title: Text("listView.title"),
                        subtitle: Text("listView.subtitle"),
                        action: self.openModal
                    )
                    
                    VStack {
                        ForEach(self.records, id: \.self.id) { record in
                            NavigationLink(
                                destination: RecordView(record: record),
                                label: {
                                    RecordItem(title: record.title, action: {})
                                })
                        }
                    }
                }
            }
            .navigationBarTitle(Text("listView.navigationBarTitle"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .accentColor(Color("NavigationBarColor"))
        .sheet(isPresented: $isModalPresented, content: {
            CreationForm(actionSave: self.closeModal)
        })

    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().preferredColorScheme(.dark)
            .environment(\.locale, .init(identifier: "en"))
    }
}
