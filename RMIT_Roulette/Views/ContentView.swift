//
//  ContentView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 14/08/2022.
//

import SwiftUI

struct ContentView: View {
    @State var isLinkActive = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("ColorGreen").edgesIgnoringSafeArea(.all)
                VStack {
                    ButtonView(destinationView: GameView(), buttonName: "Play game")
                    ButtonView(destinationView: Leaderboard(), buttonName: "Leaderboard")
                    ButtonView(destinationView: HowToPlay(), buttonName: "How to play")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
