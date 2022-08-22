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
            if (rank == 1) {
                Image("1st_rank")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 60)
            } else if (rank == 2) {
                Image("2nd_rank")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 60)
            } else if (rank == 3) {
                Image("3rd_rank")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75, height: 60)
            } else {
                Text("\(rank)")
                    .font(.system(size: 40))
                    .frame(width: 75)
            }
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.title)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .truncationMode(.tail)
                Text("\(user.highScore)")
                    .font(.title2)
                    .fontWeight(.medium)
            }
            Spacer()
            if (user.badge == Badge.pro) {
                Image("pro_badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 60)
            } else if (user.badge == Badge.master) {
                Image("master_badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 60)
            } else if (user.badge == Badge.legend) {
                Image("legend_badge")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65, height: 60)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color("ColorYellow"))
    }
}

struct LeaderboardRow_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardRow(user: User(username: "Hello worldfffffffffffffffffffffffffff:))))", highScore: 10000, badge: Badge.pro), rank: 1)
    }
}
