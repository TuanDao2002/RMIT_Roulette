//
//  Leaderboard.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI
import AudioToolbox

struct Leaderboard: View {
    @Environment(\.dismiss) var dismiss
    private var userVM: UserViewModel
    private var users : [User] = []
    
    init(userVM: UserViewModel) {
        self.userVM = userVM
        self.users = userVM.returnSorted()
    }
    
    var body: some View {
        ZStack {
            Color("ColorGreen").edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack(spacing: 10) {
                    Text("Leaderboard")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    
                    ForEach(0..<users.count, id: \.self) { index in
                        LeaderboardRow(user: users[index], rank: index < 10 ? index + 1 : index + 100)
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
                    AudioServicesPlaySystemSound(1306)
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
                    userVM.add(newUser: User(username: "tuan", highScore: 99999, badge: Badge.pro))
                }) {
                    Text("add user")
                }.modifier(ButtonModifier())
            }
            .modifier(AddBottomBarModifier()),
            alignment: .bottom
        )
    }

}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        Leaderboard(userVM: UserViewModel())
    }
}
