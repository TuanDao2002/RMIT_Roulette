//
//  ResumeView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 23/08/2022.
//

import SwiftUI

struct ResumeView: View {
    
    @State private var spinDegress: Double = 0
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 5) {
                Button(action: {
                    
                }) {
                    Image(systemName: "house.circle")
                      .foregroundColor(Color("ColorYellow"))
                }
                .modifier(IconModifier())

                Image("roulette_wheel")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: spinDegress))
                    .onAppear(perform: {
                        withAnimation(Animation.linear(duration: 5)
                            .repeatForever(autoreverses: false)) {
                                spinDegress = 720
                            }
                        }
                    )
                
                Button(action: {
                    
                }) {
                    Text("Resume")
                }
                .modifier(ButtonModifier())
            }
        }
        .frame(minWidth: 250, idealWidth: 280, maxWidth: 290, minHeight: 120, idealHeight: 220, maxHeight: 400, alignment: .center)
        .cornerRadius(15)
    }
}

struct ResumeView_Previews: PreviewProvider {
    static var previews: some View {
        ResumeView()
    }
}
