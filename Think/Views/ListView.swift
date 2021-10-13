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
    
    private func onSave() {
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
                Section(header: Text(LocalizedStringKey("recordView.creationModal.formLabel"))) {
                    Spacer()
                    TextField(LocalizedStringKey("recordView.creationModal.titlePlaceholder"), text: $title)
                    TextField(LocalizedStringKey("recordView.creationModal.descriptionPlaceholder"), text: $description)
                }
            }
            Spacer()
            Button(action: self.onSave, label: {
                Text("recordView.creationModal.saveButtonLabel")
                    .padding()
                    .foregroundColor(.purple)
            })
        }
        .background(Color("AccentColor"))
    }
}

struct ListView: View {
    @FetchRequest(
        entity: Sound.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Sound.updatedAt, ascending: false)]
    ) var sounds: FetchedResults<Sound>
    
    @State var isModalPresented = false
    
    init() {
        // FIXME: Remove deprecated after
        let customStatusBar =  UIView()
        customStatusBar.frame = UIApplication.shared.statusBarFrame
        customStatusBar.backgroundColor = UIColor.init(named: "AccentColor")
        UIApplication.shared.keyWindow?.addSubview(customStatusBar)
        
        UINavigationBar.appearance().backgroundColor = UIColor.init(named: "AccentColor")

        UITableView.appearance().backgroundColor = UIColor.init(named: "AccentColor")
        UITableView.appearance().sectionHeaderHeight = 8.0
        UITableView.appearance().sectionFooterHeight = 0.0
        UITableView.appearance().separatorStyle = .none
    }
    
    func openModal() {
        self.isModalPresented.toggle()
    }
    
    func closeModal() {
        self.isModalPresented.toggle()
    }
    
    // TODO fix it
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
                Header( // TODO: add trad here!
                    title: Text("listView.title"),
                    subtitle: Text("listView.subtitle"),
                    action: self.openModal
                )
                
                List {
                    ForEach(self.sounds, id: \.self) { sound in
                        Section {
                            HStack {
                                RecordItem(
                                    title: sound.title!,
                                    id: sound.id!
                                )
                                
                                NavigationLink(destination: RecordView(sound: sound)) {
                                    EmptyView()
                                }
                                .frame(width: 0)
                                .opacity(0)
                            }
                        }
                        .background(Color("ItemBackground"))
                        .listRowInsets(EdgeInsets())
                    }
                    .onDelete(perform: self.deleteItem)
                }
            }
            .background(Color("AccentColor"))
            .navigationBarTitle(Text("listView.navigationBarTitle"))
        }
        .accentColor(Color("NavigationBarColor"))
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $isModalPresented, content: {
            CreationForm(closeModal: self.closeModal)
        })
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().preferredColorScheme(.light)
            .environment(\.locale, .init(identifier: "en"))
    }
}
