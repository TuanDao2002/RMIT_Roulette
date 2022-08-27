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
import AudioToolbox

// View to display all users sorted descending based on their highscores
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
                        .foregroundColor(Color("LeaderboardHeaderColor"))
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
                    AudioServicesPlaySystemSound(1306)
                    dismiss()
                }) {
                    VStack {
                        Image(systemName: "house.circle")
                            .foregroundColor(.black)
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
        Leaderboard(userVM: UserViewModel())
    }
}
