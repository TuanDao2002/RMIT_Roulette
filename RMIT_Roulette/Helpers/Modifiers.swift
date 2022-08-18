//
//  Modifiers.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 14/08/2022.
//

import SwiftUI

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

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title)
            .padding()
            .shadow(radius: 5)
            .buttonStyle(GrowingButton())
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(.gray)
            .cornerRadius(20)
            .shadow(color: .gray, radius: 10)
    }
}

struct StatusTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: 250)
            .padding()
            .background(Color("ColorYellow"))
            .clipShape(Capsule())
            .opacity(0.7)
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}

struct IconModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.system(size: 35))
            .clipShape(Circle())
            .opacity(0.7)
    }
}
