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
    @State private var lastPosition: Int32 = 0
    @FetchRequest var records: FetchedResults<Record>
    
    init(sound: Binding<Sound>) {
        self._sound = sound
        
        self._records = FetchRequest<Record>(
            entity: Record.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \Record.position, ascending: true)],
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
        RecordEntity.create(at: self.lastPosition, in: self.sound)
        self.lastPosition += 1
    }
    
    private func delete(indexSet: IndexSet) {
        let index = indexSet[indexSet.startIndex]
        let id = self.records[index].id!
        if let uuid = RecordEntity.delete(by: id) {
            print("Record \(uuid) deleted!")
            self.lastPosition -= 1
        }
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
            List {
                ForEach(records, id: \.self) { record in
                    RecordItem(label: record.label!, position: record.position)
                        .listRowBackground(Color.clear)
                }
                .onMove(perform: self.move)
                .onDelete(perform: self.delete)
            }
             .navigationBarItems(trailing: EditButton())
             .listStyle(PlainListStyle())
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
        .onAppear {
            self.lastPosition = Int32(self.records.count + 1)
        }
    }
    
    private func move(from source: IndexSet, to destination: Int) {
        var recordsCopy: [Record] = records.map { $0 }
        
        recordsCopy.move(fromOffsets: source, toOffset: destination)
        
        for index in recordsCopy.indices {
            if let currentIndex = records.firstIndex(of: recordsCopy[index]) {
                records[currentIndex].position = Int32(index + 1)
            }
        }
        
        RecordEntity.save(errorLog: "Error while changing order")
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
