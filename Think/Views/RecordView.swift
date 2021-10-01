//
//  RecordView.swift
//  Think
//
//  Created by Tony Gorez on 16/07/2021.
//

import SwiftUI

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
    var actionSave: () -> Void
    @Binding var title: String
    @Binding var description: String
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("recordView.editionModal.formLabel")) {
                    TextField("recordView.editionModal.titlePlaceholder", text: $title)
                    TextField("recordView.editionModal.descriptionPlaceholder", text: $description)
                }
            }
            Spacer()
            Button(action: actionSave, label: {
                Text("recordView.editionModal.saveButtonLabel")
            }).foregroundColor(.purple)
        }
        // Bad practice ?
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

struct RecordView: View {
    let sound: Sound
    
    @State private var title: String
    @State private var description: String
    @State private var isModalPresented = false
    
    init(sound: Sound) {
        self.sound = sound
        _title = State(initialValue: sound.title!)
        _description = State(initialValue: sound.desc!)
    }
    
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
                    title: Text(self.title),
                    subtitle: Text(self.description),
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
        .edgesIgnoringSafeArea(.bottom)
        .fullScreenCover(isPresented: $isModalPresented, content: {
            EditionForm(actionSave: self.closeEditionModal, title: $title, description: $description)
        })
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        Text("Todo")
    }
}
