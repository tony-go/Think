//
//  SoundView.swift
//  Think
//
//  Created by Tony Gorez on 17/12/2023.
//

import SwiftUI

struct SoundItem: View {
    var title: String
    var destination: SoundView
    
    var body: some View {
        Section {
            HStack {
                HStack(alignment: .center, content: {
                    Text(self.title)
                        .font(.title2)
                    Spacer()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                })
                .frame(height: 50.0)
                .padding()
                NavigationLink(destination: destination) {
                    EmptyView()
                }
                .frame(width: 0)
                .opacity(0)
            }
        }
        .background(Color("ButtonBackground"))
        .listRowInsets(EdgeInsets())
    }
}

struct SoundItem_Previews: PreviewProvider {
    static var previews: some View {
        let ctx = PersistenceController.shared.container.viewContext
        
        let sound = Sound(context: ctx)
        sound.id = UUID()
        sound.title = "Fake sound"
        sound.desc = "This is a sound"
        sound.createdAt = Date()
        sound.updatedAt = Date()
        
        return SoundItem(title: "An audio", destination: SoundView(sound: Binding.constant(sound)))
    }
}
