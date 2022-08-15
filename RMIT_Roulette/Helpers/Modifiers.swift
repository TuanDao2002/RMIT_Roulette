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
          .buttonStyle(GrowingButton())
      }
}
