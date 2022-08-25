//
//  ResumeView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 23/08/2022.
//

import SwiftUI

// View to allows users to continue the game or back to home menu
struct ResumeView<Content: View>: View {
    
    private var destinationView: Content
    @State private var spinDegress: Double = 0
    @Binding var resume: Bool
    
    init(destinationView: Content, resume: Binding<Bool>) {
        self.destinationView = destinationView
        self._resume = resume
    }
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 5) {
                Button(action: {
                    resume = false
                }) {
                    Image(systemName: "house.circle")
                      .foregroundColor(Color("ColorYellow"))
                }
                .modifier(IconModifier())

                Image("roulette_wheel")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: spinDegress))

                NavigateButtonView(destinationView: destinationView, buttonName: "Continue", changeBackgroundMusic: true, customBackButton: true)
                    .modifier(ButtonModifier())
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(Animation.linear(duration: 5)
                    .repeatForever(autoreverses: false)) {
                        spinDegress = 720
                    }
            }
        }
        
        .frame(minWidth: 250, idealWidth: 280, maxWidth: 290, minHeight: 120, idealHeight: 220, maxHeight: 400, alignment: .center)
        .cornerRadius(15)
    }
}

struct ResumeView_Previews: PreviewProvider {
    static var previews: some View {
        ResumeView(destinationView: HowToPlay(backToMenu: true), resume: .constant(true))
    }
}
