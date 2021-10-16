//
//  RecordItem.swift
//  Think
//
//  Created by Tony Gorez on 28/07/2021.
//

import SwiftUI

struct RecordItem: View {
    var title: String
    var id: UUID

    var body: some View {
            HStack(alignment: .center, content: {
                Text(self.title)
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            })
            .frame(height: 50.0)
            .padding()
    }
}

struct RecordItem_Previews: PreviewProvider {
    static var previews: some View {
        Text("lol")
    }
}
