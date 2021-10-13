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
    
    @State var currentUserInteractionCellID: String?
    @State var isModalPresented = false
    @State var navigationViewIsActive = false
    
    init() {
        // FIXME: Remove deprecated after
        let customStatusBar =  UIView()
        customStatusBar.frame = UIApplication.shared.statusBarFrame
        customStatusBar.backgroundColor = UIColor.init(named: "AccentColor")
        UIApplication.shared.keyWindow?.addSubview(customStatusBar)
        
        UINavigationBar.appearance().backgroundColor = UIColor.init(named: "AccentColor")
    }
    
    func openModal() {
        self.isModalPresented.toggle()
    }
    
    func closeModal() {
        self.isModalPresented.toggle()
    }
    
    // TODO fix it
    func deleteItem(_ uuid: UUID) {
        if let uuid = SoundEntity.delete(by: uuid) {
            print("\(uuid) deleted")
        }
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                Header(
                    title: Text("listView.title"),
                    subtitle: Text("listView.subtitle"),
                    action: self.openModal
                )
                
                ScrollView {
                    GeometryReader { geometry in
                        LazyVStack(alignment: .center, spacing: 10) {
                            ForEach(self.sounds, id: \.self) { sound in
                                LazyHStack {
                                    RecordItem(
                                        title: sound.title!,
                                        id: sound.id!.uuidString,
                                        availableWidth: geometry.size.width - 40,
                                        deletionCallback: { uuid in
                                            self.deleteItem(uuid)
                                        },
                                        currentUserInteractionCellID: $currentUserInteractionCellID
                                    )
                                    
                                    NavigationLink(destination: RecordView(sound: sound), isActive: self.$navigationViewIsActive) {
                                        EmptyView()
                                    }
                                }
                                .onTapGesture {
                                    if self.currentUserInteractionCellID == sound.id?.uuidString {
                                        self.currentUserInteractionCellID = "-1"
                                    } else {
                                        self.navigationViewIsActive.toggle()
                                    }
                                }
                            }
                        }
                    }
                    .navigationBarTitle(Text("listView.navigationBarTitle"))
                }
            }
            .background(Color("AccentColor"))
        }
        .accentColor(Color("NavigationBarColor"))
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: self.$isModalPresented, content: {
            CreationForm(closeModal: self.closeModal)
        })
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .preferredColorScheme(.light)
            .environment(\.locale, .init(identifier: "en"))
    }
}
