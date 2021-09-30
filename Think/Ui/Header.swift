//
//  Header.swift
//  Think
//
//  Created by Tony Gorez on 18/07/2021.
//

import SwiftUI

private struct Title: View {
    public var label = String()
    
    var body: some View {
        Text(self.label)
            .foregroundColor(.white)
            .font(.largeTitle).bold()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.all)
    }
}

private struct SubTitle: View {
    public var label = String()
    
    var body: some View {
        Text(self.label)
            .foregroundColor(.white)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(.all)
    }
}

struct Header: View {
    public var title = String()
    public var subtitle = String()
    public var actionIconName = "plus"
    public var action: () -> Void

    
    var body: some View {
        RoundedRectangle(cornerRadius: 25.5)
            .fill(
                LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
            )
            .frame(
                width: UIScreen.main.bounds.width - 30,
                height: 200,
                alignment: .center
            )
            .overlay(
                HStack {
                    VStack {
                        Title(label: self.title)
                        SubTitle(label: self.subtitle)
                    }
                    Button(action: self.action) {
                        Image(systemName: self.actionIconName)
                    }.padding()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
            )
        }
    }

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(
            title: "Hi,",
            subtitle: "How are you ?",
            actionIconName: "plus",
            action: {
               debugPrint("action")
            }
        )
    }
}
    
