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

// Modifier for growing animation when button is clicked
struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color("ColorYellow"))
            .foregroundColor(.black)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// Modifier for button style
struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding()
            .shadow(radius: 5)
            .buttonStyle(GrowingButton())
    }
}

// Modifier for oval text field for user input
struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .foregroundColor(.black)
            .font(.title2)
            .padding(15)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .white, radius: 1)
            .frame(minWidth: 80, idealWidth: 180, maxWidth: 280)
    }
}

// Modifier for the money and high score status of user
struct StatusTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.black)
            .frame(maxWidth: 250)
            .padding()
            .background(Color("ColorYellow"))
            .clipShape(Capsule())
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

// Modifier for the bonus users gain while playing the game
struct ShowBonus: ViewModifier {
    var bonus: Int
    var statusAppear: Bool
    func body(content: Content) -> some View {
        content
            .foregroundColor(bonus > 0 ? .green : .red)
            .frame(maxWidth: 250, alignment: .trailing)
            .opacity(statusAppear ? 1 : 0)
    }
}

// Modifier to blur the view when mileston view appears
struct BlurViewWhenMilestoneAppear: ViewModifier {
    var showAchievement: Bool
    func body(content: Content) -> some View {
        content
            .blur(radius: showAchievement ? 5 : 0 , opaque: false)
            .allowsHitTesting(!showAchievement)
    }
}

// Modifier to blur the view when register view appears
struct BlurViewWhenRegisterAppear: ViewModifier {
    var showRegister: Bool
    func body(content: Content) -> some View {
        content
            .blur(radius: showRegister ? 5 : 0 , opaque: false)
            .allowsHitTesting(!showRegister)
    }
}

// Modifier to blur the view when resume view appears
struct BlurViewWhenResumeAppear: ViewModifier {
    var resume: Bool
    func body(content: Content) -> some View {
        content
            .blur(radius: resume ? 5 : 0 , opaque: false)
            .allowsHitTesting(!resume)
    }
}

// Modifier for icon style
struct IconModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.system(size: 35))
            .clipShape(Circle())
            .opacity(0.7)
    }
}

// Modifier for bottom home navigation
struct AddBottomBarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 5)
            .background(Color("ColorYellow"))
            .frame(maxHeight: UIDevice.current.userInterfaceIdiom == .phone ? 30 : 65)
            .ignoresSafeArea(edges: .bottom)
            .foregroundColor(.black)
    }
}

// Modifier for X mark
struct AddXMarkModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color("ColorYellow"))
            .padding(.top, 20)
            .padding(.trailing, 20)
    }
}

