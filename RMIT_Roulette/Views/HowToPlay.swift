//
//  HowToPlay.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI

struct HowToPlay: View {
    @Environment(\.dismiss) var dismiss
    private var backToMenu = false

    init(backToMenu: Bool) {
        self.backToMenu = backToMenu
    }
    
    var body: some View {
        ZStack {
            Color("ColorGreen").edgesIgnoringSafeArea(.all)
            VStack {
                Text("How to play")
            }
        }
        
        .overlay(
            Button(action: {
              dismiss()
            }) {
                Image(systemName: backToMenu ?  "house.circle" : "xmark.circle")
                    .font(.largeTitle)
            }
            .foregroundColor(.black)
            .padding(.top, 30)
            .padding(.trailing, 20), alignment: .topTrailing
        )
    }
}

struct HowToPlay_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlay(backToMenu: true)
    }
}
