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
    var onDelete: (UUID) -> Void
    
    @State var swipeOffset = 0
    @State var presentDeleteButton = false
    
    func deleteItem() {
        self.presentDeleteButton = false
        onDelete(self.id)
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 22.5)
                .foregroundColor(Color("ItemBackground"))
                .frame(idealWidth: UIScreen.main.bounds.width - 30, maxWidth: UIScreen.main.bounds.width - 30, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 80, maxHeight: 80, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .overlay(
                    HStack(alignment: .center, content: {
                        Text(self.title)
                            .font(.title2)
                            .foregroundColor(.white)
                        Spacer()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }).padding()
                )
                .offset(x: CGFloat(self.swipeOffset))
                .gesture(
                    DragGesture(
                        minimumDistance: 0,
                        coordinateSpace: .local
                    ).onChanged({ value in
                        if value.translation.width < 0 {
                            if self.presentDeleteButton == false {
                                self.swipeOffset = Int(value.translation.width)
                            }

                            if value.translation.width < -(UIScreen.main.bounds.width / 3) {
                                self.presentDeleteButton = true
                            }
                        }
                        
                        if value.translation.width > 0 && self.presentDeleteButton {
                            self.swipeOffset = 30
                            self.presentDeleteButton = false
                        }
                    }).onEnded({ _ in self.swipeOffset = 0}))
                // TODO: move it into a component
                if (self.presentDeleteButton) {
                    Button(action: self.deleteItem) {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50, alignment: .leading)
                                .foregroundColor(.red)
                            Image(systemName: "trash")
                                .foregroundColor(.white)
                        }
                    }.offset(x: 100)
                }
        }
    }
}

struct RecordItem_Previews: PreviewProvider {
    static var previews: some View {
        RecordItem(title: "Cours du Lundi.", onDelete: {_ in})
    }
}
