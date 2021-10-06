//
//  RecordItem.swift
//  Think
//
//  Created by Tony Gorez on 28/07/2021.
//

import SwiftUI

struct RecordItem: View {
    var title = String()
    var id = UUID()

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22.5)
                .foregroundColor(Color("ItemBackground"))
                .frame(
                    idealWidth: UIScreen.main.bounds.width - 30,
                    maxWidth: UIScreen.main.bounds.width - 30,
                    minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                    idealHeight: 80,
                    maxHeight: 80,
                    alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/
                )
                .overlay(
                    HStack(alignment: .center, content: {
                        Text(self.title)
                            .font(.title2)
                            .foregroundColor(.white)
                        Spacer()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }).padding()
                )
        }
    }
}

struct RecordItem_Previews: PreviewProvider {
    static var previews: some View {
        RecordItem(title: "Cours du Lundi.")
    }
}
