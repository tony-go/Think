//
//  SoundItem.swift
//  Think
//
//  Created by Tony Gorez on 28/07/2021.
//

import SwiftUI

struct RecordItem: View {
    var label: String
    var position: Int32

    var body: some View {
                                    HStack {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                                .fill(Color("ButtonBackground"))
                                            HStack {
                                                Circle()
                                                    .fill(Color.blue)
                                                    .frame(width: 20, height: 20)
                                                Text("\(label) \(position)")
                                                Spacer()
                                            }.padding(.horizontal)
                                        }
                                        Spacer().frame(width: 50)
                                        HStack {
                                            Button(action: {}) {
                                                ZStack {
                                                    Circle()
                                                        .fill(Color("ButtonBackground"))
                                                        .frame(width: 42, height: 42)
                                                    Image(systemName: "play")
                                                        .foregroundColor(Color("NavigationBarColor"))
                                                        .font(.title2)
                                                }
                                            }
                                            Button(action: {}) {
                                                ZStack {
                                                    Circle()
                                                        .fill(Color("ButtonBackground"))
                                                        .frame(width: 42, height: 42)
                                                    Image(systemName: "record.circle")
                                                        .foregroundColor(.red)
                                                        .font(.title2)
                                                }
                                           }
                                        }
                                    }
                                    .padding(.horizontal)
                                    .frame(height: 42)
    }
}

struct RecordItem_Previews: PreviewProvider {
    static var previews: some View {
        RecordItem(label: "Intro", position: 3)
    }
}
