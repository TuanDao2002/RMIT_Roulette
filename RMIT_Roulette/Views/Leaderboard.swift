//
//  Leaderboard.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI

struct Leaderboard: View {
    @Environment(\.dismiss) var dismiss

    private var users = [
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro"),
        User(username: "tuan", highScore: 100, badge: "Pro")
    ]
    
    var body: some View {
        ZStack {
            Color("ColorGreen").edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 10) {
                    Text("Leaderboard")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    
                    ForEach(0..<users.count, id: \.self) { index in
                        LeaderboardRow(user: users[index], rank: index + 1)
                    }
                }
                .padding(.bottom, UIDevice.current.userInterfaceIdiom == .phone ? 45 : 65)
                .padding()
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
            }
            .modifier(AddBottomBarModifier()),
            alignment: .bottom
        )
    }

}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard()
    }
}
