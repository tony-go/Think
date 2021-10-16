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
                    title: Text(self.sound.title!),
                    subtitle: Text(self.sound.desc!),
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
        .background(Color("AccentColor"))
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
        Text("Todo")
    }
}
