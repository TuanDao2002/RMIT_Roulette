//
//  LeaderboardRow.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 19/08/2022.
//

import SwiftUI

struct LeaderboardRow: View {
    var user: User
    var rank: Int
    
    var body: some View {
        HStack(spacing: 20) {
            Text("\(rank)")
                .frame(width: 40)
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.title3)
                    .fontWeight(.medium)
                Text("\(user.highScore)")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            Spacer()
            Text(user.badge)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("ColorYellow"))
    }
}

struct LeaderboardRow_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardRow(user: User(username: "Tuan", highScore: 100, badge: "Pro"), rank: 100)
    }
}
