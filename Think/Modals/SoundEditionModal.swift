//
//  SoundEditionModal.swift
//  Think
//
//  Created by Tony Gorez on 16/10/2021.
//

import SwiftUI

struct SoundEditionModal: View {
    var closeModal: () -> Void
    var sound: Sound

    @State var title: String
    @State var description: String
    
    init(
        sound: Sound,
        closeModal: @escaping () -> Void
    ) {
        self.sound = sound
        self.closeModal = closeModal
        
        _title = State(initialValue: sound.title!)
        _description = State(initialValue: sound.desc!)
    }
    
    func save() {
        SoundEntity.update(
            id: self.sound.id!,
            newTitle: self.title,
            newDescription: self.description
        )
        
        self.closeModal()
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("SoundView.editionModal.formLabel").padding()) {
                    TextField("SoundView.editionModal.titlePlaceholder", text: $title)
                    TextField("SoundView.editionModal.descriptionPlaceholder", text: $description)
                }
            Button(action: self.save, label: {
                Text("SoundView.editionModal.saveButtonLabel")
            }).foregroundColor(.purple)
            }
        }
    }
}

struct SoundEditionModal_Previews: PreviewProvider {
    static func fakeCloseModal() {}
    static var previews: some View {
        let ctx = PersistenceController.shared.container.viewContext
        
        let sound = Sound(context: ctx)
        sound.id = UUID()
        sound.title = "Fake sound"
        sound.desc = "This is a sound"
        sound.createdAt = Date()
        sound.updatedAt = Date()
        
        return SoundEditionModal(sound: sound, closeModal: fakeCloseModal)
    }
}
