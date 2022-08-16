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
                    Image("roulette_wheel")
                    Text("RMIT Roulette")
                        .foregroundColor(Color("ColorYellow"))
                        .fontWeight(.bold)
                        .font(.system(size: 40))
                    ButtonView(destinationView: GameView(), buttonName: "Play game")
                    ButtonView(destinationView: Leaderboard(backToMenu: true), buttonName: "Leaderboard")
                    ButtonView(destinationView: HowToPlay(backToMenu: true), buttonName: "How to play")
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
