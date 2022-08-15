//
//  ButtonView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI

struct ButtonView<Content: View>: View {
    private var buttonName: String
    private var destinationView: Content

    init(destinationView: Content, buttonName: String) {
        self.destinationView = destinationView
        self.buttonName = buttonName
    }
    
    @State var isLinkActive = false

    var body: some View {
        NavigationLink(destination: destinationView, isActive: $isLinkActive) {
            Button(action: {
                self.isLinkActive = true
            }) {
                Text(buttonName)
                    .frame(maxWidth: .infinity)
            }
            .modifier(ButtonModifier())
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(destinationView: GameView(), buttonName: "Play game")
    }
}