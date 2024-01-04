//
//  SoundView.swift
//  Think
//
//  Created by Tony Gorez on 16/07/2021.
//

import SwiftUI

struct SoundView: View {
    @Binding var sound: Sound
    @State private var isModalPresented = false
    @FetchRequest var records: FetchedResults<Record>
    
    init(sound: Binding<Sound>) {
        print("init")
        self._sound = sound
        
        self._records = FetchRequest<Record>(
            entity: Record.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "fromSound == %@", sound.wrappedValue)
        )
    }
    
    private func openEditionModal() {
        self.isModalPresented = true
    }
    
    private func closeEditionModal() {
        self.isModalPresented = false
    }
    
    private func record() {
        print("Add new record")
        // TODO: handle position properly
        RecordEntity.create(at: 1, in: self.sound)
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
                LazyVStack { // Use LazyVStack to load views on demand
                                ForEach(records, id: \.self) { record in
                                    RecordItem(label: record.label!, position: record.position)
                               }
                }
                }.padding(.horizontal)
            Spacer()
            ActionBar(editAction: self.openEditionModal, record: self.record).frame(alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
        .fullScreenCover(isPresented: $isModalPresented, content: {
            SoundEditionModal(
                sound: self.sound,
                closeModal: self.closeEditionModal
            )
        })
    }
}

struct SoundView_Previews: PreviewProvider {
    static var previews: some View {
        let ctx = PersistenceController.shared.container.viewContext
        
        let sound = Sound(context: ctx)
        sound.id = UUID()
        sound.title = "Fake sound"
        sound.desc = "This is a sound"
        sound.createdAt = Date()
        sound.updatedAt = Date()
        
        return SoundView(sound: Binding.constant(sound))
    }
}
