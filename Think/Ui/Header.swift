//
//  Header.swift
//  Think
//
//  Created by Tony Gorez on 18/07/2021.
//

import SwiftUI

private struct Title: View {
    public var Label = Text(verbatim: "")
    
    var body: some View {
        self.Label
            .foregroundColor(.white)
            .font(.largeTitle).bold()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.all)
    }
}

private struct SubTitle: View {
    public var Label = Text(verbatim: "")
    
    var body: some View {
        self.Label
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.all)
    }
}

struct Header: View {
    public var title = Text(verbatim: "")
    public var subtitle = Text(verbatim: "")
    public var actionIconName = "plus"
    public var action: () -> Void
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.5)
            .fill(
                LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
            )
            .frame(
                height: 200,
                alignment: .center
            )
            .overlay(
                HStack {
                    VStack {
                        Title(Label: self.title)
                        SubTitle(Label: self.subtitle)
                    }
                    Button(action: self.action) {
                        Image(systemName: self.actionIconName)
                    }.padding()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            )
            .padding(.horizontal)
        }
    }

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(
            title: Text("Hi,"),
            subtitle: Text("How are you ?"),
            actionIconName: "plus",
            action: {
               debugPrint("action")
            }
        )
    }
}
    
