/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Dao Kha Tuan
  ID: 3877347
  Created  date: 14/08/2022
  Last modified: 27/08/2022
  Acknowledgement: None
*/

import SwiftUI
import AudioToolbox

// View to display the menu for users
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
                    // display navigation buttons for users to move to other views
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
                
                if (resume) { // display the resume view if users exit while playing the game
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
