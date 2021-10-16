//
//  ListView.swift
//  Think
//
//  Created by Tony Gorez on 09/07/2021.
//

import SwiftUI
import CoreData

struct CreationForm: View {
    var closeModal: () -> Void
    
    @State private var title = ""
    @State private var description = ""
    
    private func onSave() {
        SoundEntity.create(title: self.title, description: self.description)
        
        self.closeModal()
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text(LocalizedStringKey("ListView.creationModal.formLabel"))) {
                    Spacer()
                    TextField(LocalizedStringKey("ListView.creationModal.titlePlaceholder"), text: $title)
                    TextField(LocalizedStringKey("ListView.creationModal.descriptionPlaceholder"), text: $description)
                }
            }
            Spacer()
            Button(action: self.onSave, label: {
                Text("ListView.creationModal.saveButtonLabel")
                    .padding()
                    .foregroundColor(.purple)
            })
        }
        .background(Color("AccentColor"))
    }
}

struct ListView: View {
    @FetchRequest(entity: Sound.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Sound.updatedAt, ascending: false)])
        var sounds: FetchedResults<Sound>
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
                                        title: sound.title!,
                                        id: sound.id!
                                    )
                                    
                                    NavigationLink(destination: SoundView(sound: Binding.constant(sound))) {
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
                    } else {
                        Text("No sound available") // TODO: add a trad
                    }
                }
            }
            .background(Color("AccentColor"))
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
