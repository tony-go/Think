//
//  ListView.swift
//  Think
//
//  Created by Tony Gorez on 09/07/2021.
//

import SwiftUI

struct CreationForm: View {
    var closeModal: () -> Void
    
    @State private var title = ""
    @State private var description = ""

    @Environment(\.managedObjectContext) var managedObjectContext
    
    func onSave() {
        let sound = Sound(context: managedObjectContext)
        sound.title = self.title
        sound.desc = self.description
        sound.id = UUID()
        sound.createdAt = Date()
        sound.updatedAt = Date()
        PersistenceController.shared.save()
        
        self.closeModal()
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
            Button(action: self.onSave, label: {
                Text("recordView.creationModal.saveButtonLabel")
            }).foregroundColor(.purple)
        }
        // Bad practice ?
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

struct ListView: View {
    @FetchRequest(
        entity: Sound.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Sound.updatedAt, ascending: false)]
    ) var sounds: FetchedResults<Sound>

    @State var isModalPresented = false
    
    func openModal() {
        self.isModalPresented = true
    }
    
    func closeModal() {
        self.isModalPresented = false
    }
    
    func deleteItem(id: UUID) {
        print("delete \(id)")
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
                        ForEach(self.sounds, id: \.self) { sound in
                            NavigationLink(
                                destination: RecordView(sound: sound),
                                label: {
                                    RecordItem(
                                        title: sound.title!,
                                        id: sound.id!,
                                        onDelete: self.deleteItem
                                    )
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
            CreationForm(closeModal: self.closeModal)
        })

    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().preferredColorScheme(.dark)
            .environment(\.locale, .init(identifier: "en"))
    }
}
