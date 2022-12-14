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

// View display navigation buttons to another view
struct NavigateButtonView<Content: View>: View {
    private var buttonName: String
    private var destinationView: Content
    private var changeBackgroundMusic: Bool = false
    private var customBackButton: Bool = false

    init(destinationView: Content, buttonName: String, changeBackgroundMusic: Bool, customBackButton: Bool) {
        self.destinationView = destinationView
        self.buttonName = buttonName
        self.changeBackgroundMusic = changeBackgroundMusic
        self.customBackButton = customBackButton
    }
    
    @State private var isLinkActive = false

    var body: some View {
        NavigationLink(destination: destinationView.navigationBarHidden(customBackButton), isActive: $isLinkActive) {
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
        }
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NavigateButtonView(destinationView: HowToPlay(backToMenu: true), buttonName: "How to play", changeBackgroundMusic: false, customBackButton: true)
    }
}
