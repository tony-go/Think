//
//  RecordView.swift
//  Think
//
//  Created by Tony Gorez on 16/07/2021.
//

import SwiftUI
import CoreData

// TODO: move in it's own file
struct ActionBar: View {
    public var editAction: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
               .fill(Color("ItemBackground"))
               .frame(height: 70)
            HStack {
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color("ButtonBackground"))
                            .frame(width: 50, height: 50)
                        Image(systemName: "play")
                            .foregroundColor(Color("NavigationBarColor"))
                            .font(.title2)
                    }
                }.offset(x: 70, y: -35)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 70, height: 70)
                        Image(systemName: "plus")
                            .foregroundColor(Color("NavigationBarColor"))
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                }
                .offset(y: -35)
                Spacer()
                Button(action: self.editAction) {
                    ZStack {
                        Circle()
                            .fill(Color("ButtonBackground"))
                            .frame(width: 50, height: 50)
                        Image(systemName: "pencil")
                            .foregroundColor(Color("NavigationBarColor"))
                            .font(.title2)
                    }
                }.offset(x: -70, y: -35)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

// Move into another file
struct EditionForm: View {
    var closeModal: () -> Void
    var sound: Sound

    // Move those ones up, to have an update
    @State var title: String
    @State var description: String
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    init(sound: Sound, closeModal: @escaping () -> Void) {
        self.sound = sound
        self.closeModal = closeModal
        
        _title = State(initialValue: sound.title!)
        _description = State(initialValue: sound.desc!)
    }
    
    func save() {
        if let updatedSound = SoundEntity.saveRecord(
            id: self.sound.id!,
            newTitle: self.title,
            newDescription: self.description
        ) {
            print("Sound \(updatedSound.id!) updated!")
        } else {
            print("Imposible to save sound '\(self.sound.title!)' (id:\(self.sound.id!)")
        }
        
        self.closeModal()
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("recordView.editionModal.formLabel")) {
                    TextField("recordView.editionModal.titlePlaceholder", text: $title)
                    TextField("recordView.editionModal.descriptionPlaceholder", text: $description)
                }
            }
            Spacer()
            Button(action: self.save, label: {
                Text("recordView.editionModal.saveButtonLabel")
            }).foregroundColor(.purple)
        }
        // Bad practice ?
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

struct RecordView: View {
    // TODO: bind it to the store
    let sound: Sound
    
    @State private var isModalPresented = false
    
    private func openEditionModal() {
        self.isModalPresented = true
    }
    
    private func closeEditionModal() {
        self.isModalPresented = false
    }
    
    var body: some View {
        VStack {
            VStack {
                Header(
                    title: Text(self.sound.title!),
                    subtitle: Text(self.sound.desc!),
                    actionIconName: "play",
                    action: {}
                )
            }.padding()
            Spacer()
            ScrollView(.vertical) {
                ForEach((1...45).reversed(), id: \.self) {
                        Text("Item \($0)")
                    }
            }
            Spacer()
            ActionBar(editAction: self.openEditionModal).frame(alignment: .bottom)
        }
        .background(Color("AccentColor"))
        .edgesIgnoringSafeArea(.bottom)
        .fullScreenCover(isPresented: $isModalPresented, content: {
            EditionForm(
                sound: self.sound,
                closeModal: self.closeEditionModal
            )
        })
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Todo")
    }
}
