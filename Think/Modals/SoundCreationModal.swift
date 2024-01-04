//
//  SoundCreationModal.swift
//  Think
//
//  Created by Tony Gorez on 16/10/2021.
//

import SwiftUI

struct SoundCreationModal: View {
    var closeModal: () -> Void
    
    @State private var title = ""
    @State private var description = ""
    
    private var isDisabled: Bool {
        if self.title.count == 0 || self.description.count == 0 {
            return true
        } else {
            return false
        }
    }
    
    private func onSave() {
        SoundEntity.create(title: self.title, description: self.description)
        
        self.closeModal()
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text(LocalizedStringKey("ListView.creationModal.formLabel")).padding()) {
                    TextField(LocalizedStringKey("ListView.creationModal.titlePlaceholder"), text: $title)
                    TextField(LocalizedStringKey("ListView.creationModal.descriptionPlaceholder"), text: $description)
                }
                Button(
                    action: self.onSave,
                    label: {
                        Text("ListView.creationModal.saveButtonLabel")
                            .foregroundColor(.purple)
                            .disabled(self.isDisabled)
                    }
                )
                .disabled(self.isDisabled)
            }
           
        }
    }
}


struct SoundCreationModal_Previews: PreviewProvider {
    static func fakeCloseModal() {}
    static var previews: some View {
        SoundCreationModal(closeModal: fakeCloseModal)
    }
}
