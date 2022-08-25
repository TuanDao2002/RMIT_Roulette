//
//  ContentView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 14/08/2022.
//

import SwiftUI
import AudioToolbox

struct MenuView: View {
    @EnvironmentObject var userVM: UserViewModel
    @Environment(\.scenePhase) var scenePhase
    @State var isLinkActive = false
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("isUseSystem") private var isUseSystem = false
    @AppStorage("level") private var level: Level = Level.easy
    @AppStorage("resume") private var resume: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("ColorGreen").edgesIgnoringSafeArea(.all)
                VStack {
                    Image("roulette_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 900, minHeight: 215, alignment: .center)
                    NavigateButtonView(destinationView: GameView(userVM: userVM, level: $level, resume: $resume), buttonName: "Play game", changeBackgroundMusic: true, customBackButton: true)
                        .modifier(ButtonModifier())
                    NavigateButtonView(destinationView: Leaderboard(userVM: userVM), buttonName: "Leaderboard", changeBackgroundMusic: false, customBackButton: true)
                        .modifier(ButtonModifier())
                    NavigateButtonView(destinationView: HowToPlay(backToMenu: true), buttonName: "How to play", changeBackgroundMusic: false, customBackButton: true)
                        .modifier(ButtonModifier())
                    NavigateButtonView(destinationView: SettingView(isDarkMode: $isDarkMode, isUseSystem: $isUseSystem, level: $level), buttonName: "Setting", changeBackgroundMusic: false, customBackButton: false)
                        .modifier(ButtonModifier())
                }
                .modifier(BlurViewWhenResumeAppear(resume: resume))
                
                if (resume) {
                    ResumeView(destinationView: GameView(userVM: userVM, level: $level, resume: $resume), resume: $resume)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())

        .onAppear(perform: {
            playSound(sound: "background_music_menu", type: "mp3", loop: true)
            SystemThemeManager.shared.handleTheme(darkMode: isDarkMode, system: isUseSystem)
        })
        
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                playSound(sound: "background_music_menu", type: "mp3", loop: true)
            } else if newPhase == .inactive || newPhase == .background {
                emptySound()
            }
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
            .environmentObject(UserViewModel())
    }
}
