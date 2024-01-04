//
//  SoundView.swift
//  Think
//
//  Created by Tony Gorez on 17/12/2023.
//

import SwiftUI

struct SoundItem: View {
    var title: String
    
    var body: some View {
        HStack(alignment: .center, content: {
            Text(self.title)
                .font(.title2)
            Spacer()
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        })
        .frame(height: 50.0)
        .padding()
    }
}

struct SoundItem_Previews: PreviewProvider {
    static var previews: some View {
        SoundItem(title: "An audio")
    }
}
