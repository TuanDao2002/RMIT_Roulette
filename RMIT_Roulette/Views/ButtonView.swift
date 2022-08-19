//
//  ButtonView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI
import AudioToolbox

struct ButtonView<Content: View>: View {
    private var buttonName: String
    private var destinationView: Content
    private var changeBackgroundMusic: Bool = false

    init(destinationView: Content, buttonName: String, changeBackgroundMusic: Bool) {
        self.destinationView = destinationView
        self.buttonName = buttonName
        self.changeBackgroundMusic = changeBackgroundMusic
    }
    
    @State private var isLinkActive = false

    var body: some View {
        NavigationLink(destination: destinationView.navigationBarHidden(true), isActive: $isLinkActive) {
            Button(action: {
                AudioServicesPlaySystemSound(1306)
                if (changeBackgroundMusic) {
                    emptySound()
                }
                self.isLinkActive = true
            }) {
                Text(buttonName)
                    .frame(maxWidth: 500)
            }
            .modifier(ButtonModifier())
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(destinationView: GameView(), buttonName: "Play game", changeBackgroundMusic: true)
    }
}
