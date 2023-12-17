//
//  ListView.swift
//  Think
//
//  Created by Tony Gorez on 09/07/2021.
//

import SwiftUI
import CoreData

@available(iOS 16.0, *)
struct ListView: View {
    // Todo: move request params into SoundEntity
    @FetchRequest(entity: Sound.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Sound.updatedAt, ascending: false)])
        var sounds: FetchedResults<Sound>
    @State var isModalPresented = false
    
    func openModal() {
        self.isModalPresented.toggle()
    }
    
    func closeModal() {
        self.isModalPresented.toggle()
    }
    
    func deleteItem(indexSet: IndexSet) {
        let index = indexSet[indexSet.startIndex]
        let id = self.sounds[index].id!
        if let uuid = SoundEntity.delete(by: id) {
            print("\(uuid) deleted")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Header(
                    title: Text("ListView.title"),
                    subtitle: Text("ListView.subtitle"),
                    action: self.openModal
                )
                
                List {
                    if sounds.count > 0 {
                        ForEach(self.sounds) { sound in
                            Section {
                                HStack {
                                    SoundItem(
                                        title: sound.title!
                                        // id: sound.id!
                                    )
                                    NavigationLink(destination: SoundView(sound: Binding.constant(sound))) {
                                        EmptyView()
                                    }
                                    .frame(width: 0)
                                    .opacity(0)
                                }
                            }
                            .background(Color("ButtonBackground"))
                            .listRowInsets(EdgeInsets())
                        }
                        .onDelete(perform: self.deleteItem)
                    } else {
                        Text("ListView.fallback")
                    }
                }
                .scrollContentBackground(.hidden)
                .accessibilityIdentifier("SoundList")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $isModalPresented, content: {
            SoundCreationModal(closeModal: self.closeModal)
        })
    }
}

@available(iOS 16.0, *)
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().preferredColorScheme(.light)
            .environment(\.locale, .init(identifier: "en"))
    }
}
