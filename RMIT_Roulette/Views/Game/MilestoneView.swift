//
//  MilestoneView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 20/08/2022.
//

import SwiftUI

// View to display the badge user has achieved
struct MilestoneView: View {
    @Binding var showAchievement: Bool
    var badge: Badge
    var milestoneScore: Int = 0

    var body: some View {
        ZStack {
            Color("ColorBlue")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("You have achieve a new badge")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("ColorYellow"))
                    .padding()
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: 300)
                    .multilineTextAlignment(.center)
                                
                VStack {
                    if (badge == .pro) {
                        Image("pro_badge")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                    } else if (badge == .master) {
                        Image("master_badge")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                    } else if (badge == .legend) {
                        Image("legend_badge")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 150)
                    }
                   
                    Text("Your high score has reached \(badge.rawValue)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    Button {
                        self.showAchievement = false
                    } label: {
                        Text("Accept".uppercased())
                            .frame(width: 200)
                    }
                    .modifier(ButtonModifier()
                    )
                }
            }
            .padding(.vertical)
        }
        .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 400, alignment: .center)
        .cornerRadius(20)
    }
}

struct MilestoneView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneView(showAchievement: .constant(true), badge: Badge.legend)
    }
}
