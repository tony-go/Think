//
//  RecordItem.swift
//  Think
//
//  Created by Tony Gorez on 28/07/2021.
//

import SwiftUI
import SwipeCellSUI

struct RecordItem: View {
    // MARK: Internal properties
    var title: String
    var id = String()
    var availableWidth: CGFloat
    var deletionCallback: (UUID)->()
    @Binding var currentUserInteractionCellID: String?
    
    // MARK: Life cycle
    var body: some View {
        HStack(alignment: .center, content: {
            Text(self.title)
                .font(.title2)
                .foregroundColor(.white)
                .padding()
            Spacer()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        })
            .frame(height: 80)
            .background(Color("ItemBackground"))
            .swipeCell(id: self.id,
                       cellWidth: self.availableWidth,
                       leadingSideGroup: [],
                       trailingSideGroup: self.rightGroup(),
                       currentUserInteractionCellID: self.$currentUserInteractionCellID,
                       settings: SwipeCellSettings())
            .cornerRadius(25.5)
    }
    
    // MARK: Internal functions
    
    func rightGroup() -> [SwipeCellActionItem] {
        let items =  [
            SwipeCellActionItem(buttonView: {
                self.trashView(swipeOut: false)
            }, swipeOutButtonView: {
                self.trashView(swipeOut: true)
            }, backgroundColor: .red, swipeOutAction: true, swipeOutHapticFeedbackType: .warning, swipeOutIsDestructive: true) {
                self.deletionCallback(UUID(uuidString: self.id)!)
            }
        ]
        
        return items
    }
    
    func trashView(swipeOut: Bool) -> AnyView {
        VStack(spacing: 3)  {
            Image(systemName: "trash").font(.system(size: swipeOut ? 28 : 22)).foregroundColor(.white)
            // FIXME: Add localizable string here instead of "Delete"
            Text("Delete").fixedSize().font(.system(size: swipeOut ? 16 : 12)).foregroundColor(.white)
        }
        .frame(maxHeight: 80).animation(.default).castToAnyView()
    }
}

struct RecordItem_Previews: PreviewProvider {
    static var previews: some View {
        RecordItem(title: "Cell name",
                   availableWidth: UIScreen.main.bounds.width - 40,
                   deletionCallback: { uuid in
            print(uuid)
        }, currentUserInteractionCellID: .constant("-1")
        )
    }
}
