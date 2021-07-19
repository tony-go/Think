//
//  ListView.swift
//  Think
//
//  Created by Tony Gorez on 09/07/2021.
//

import SwiftUI

struct ListView: View {

    
    var body: some View {
        ZStack{
            Color.accentColor
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                ScrollView {
                    Header(
                        title: "Your audios",
                        subtitle: "Select one to edit it.",
                        action: {}
                    )
                    
//                    NavigationLink(
//                        destination: RecordView.init(),
//                        label: {
//                            Text("baseline").foregroundColor(Color.white)
//                        })
                }
            }
            
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView().preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
