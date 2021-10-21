//
//  ActionBar.swift
//  Think
//
//  Created by Tony Gorez on 16/10/2021.
//

import SwiftUI

struct ActionBar: View {
    public var editAction: () -> Void
    
    var body: some View {
        ZStack {
            Rectangle()
               .fill(Color("ItemBackground"))
               .frame(height: 70)
            HStack {
                Button(action: {}) {
                    ZStack {
                        Circle()
                            .fill(Color("ButtonBackground"))
                            .frame(width: 50, height: 50)
                        Image(systemName: "play")
                            .foregroundColor(Color("NavigationBarColor"))
                            .font(.title2)
                    }
                }.offset(x: 70, y: -35)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 70, height: 70)
                        Image(systemName: "plus")
                            .foregroundColor(Color("NavigationBarColor"))
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                }
                .offset(y: -35)
                Spacer()
                Button(action: self.editAction) {
                    ZStack {
                        Circle()
                            .fill(Color("ButtonBackground"))
                            .frame(width: 50, height: 50)
                        Image(systemName: "pencil")
                            .foregroundColor(Color("NavigationBarColor"))
                            .font(.title2)
                    }
                }
                .offset(x: -70, y: -35)
                .accessibilityIdentifier("Edit")
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ActionBar_Previews: PreviewProvider {
    static var previews: some View {
        Text("todo")
    }
}
