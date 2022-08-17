//
//  Leaderboard.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI

struct Leaderboard: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color("ColorYellow").edgesIgnoringSafeArea(.all).opacity(0.5)
            VStack {
                Text("Leaderboard")
            }
        }
        
        .overlay(
            HStack {
                Spacer()
                Button(action: {
                  dismiss()
                }) {
                    VStack {
                        Image(systemName: "house.circle")
                            .font(.system(size: 40))
                        Text("Home")
                    }
                }
                Spacer()
                Button(action: {
                  dismiss()
                }) {
                    VStack {
                        Image(systemName: "info.circle")
                            .font(.system(size: 40))
                        Text("Info")
                    }
                }
                Spacer()
                Button(action: {
                  dismiss()
                }) {
                    VStack {
                        Image(systemName: "gearshape")
                            .font(.system(size: 40))
                        Text("Setting")
                    }
                }
                Spacer()
            }
                .padding(.vertical, 5)
                .background(.white)
                .frame(maxHeight: 5)
                .ignoresSafeArea(edges: .bottom)
                .foregroundColor(.black), alignment: .bottom
        )
    }

}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard()
    }
}
