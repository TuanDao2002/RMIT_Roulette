//
//  ContentView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 14/08/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @State var isLinkActive = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("ColorGreen").edgesIgnoringSafeArea(.all)
                VStack {
                    Image("roulette_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 900, minHeight: 215, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    ButtonView(destinationView: GameView(), buttonName: "Play game", changeBackgroundMusic: true)
                    ButtonView(destinationView: Leaderboard(), buttonName: "Leaderboard", changeBackgroundMusic: false)
                    ButtonView(destinationView: HowToPlay(backToMenu: true), buttonName: "How to play", changeBackgroundMusic: false)
                }
            }
        }
        .onAppear(perform: {
            playSound(sound: "background_music_menu", type: "mp3", loop: true)
        })
        
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                playSound(sound: "background_music_menu", type: "mp3", loop: true)
            } else if newPhase == .inactive || newPhase == .background {
                emptySound()
            }
        }
        
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
