//
//  RecordView.swift
//  Think
//
//  Created by Tony Gorez on 16/07/2021.
//

import SwiftUI

struct ActionBar: View {
    var body: some View {
        ZStack {
            Rectangle()
               .fill(Color("ItemBackground"))
               .frame(height: 80)
            HStack {
                Button(action: {}) {
                    Image(systemName: "play")
                        .foregroundColor(Color("NavigationBarColor"))
                        .font(.title2)
                }.offset(x: 70)
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 70, height: 70)
                }
                .offset(y: -23)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "pencil")
                        .foregroundColor(Color("NavigationBarColor"))
                        .font(.title2)
                }.offset(x: -70)
            }
        }
        .ignoresSafeArea()
    }
}

struct RecordView: View {
    let record: Record
    
    @State private var title: String
    @State private var description: String
    
    init(record: Record) {
        self.record = record
        _title = State(initialValue: record.title)
        _description = State(initialValue: record.description)
    }
    
    var body: some View {
        VStack {
            VStack {
                Header(title: self.title, subtitle: self.description, actionIconName: "play", action: {})
            }.padding()
            Spacer()
            ScrollView(.vertical) {
                ForEach((1...45).reversed(), id: \.self) {
                        Text("Item \($0)")
                    }
            }
            Spacer()
            ActionBar().frame(alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(record: Record(title: "Hello", description: "This is my first memo")).preferredColorScheme(.dark)
    }
}
