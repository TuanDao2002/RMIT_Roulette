//
//  MilestoneView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 20/08/2022.
//

import SwiftUI

struct MilestoneView: View {
    @Environment(\.dismiss) var dismiss
    var badge: Badge
    var milestoneScore: Int = 0
    
    init(badge: Badge) {
        self.badge = badge
        if (badge == .pro) {
            self.milestoneScore = 1000
        } else if (badge == .master) {
            self.milestoneScore = 5000
        } else if (badge == .legend) {
            self.milestoneScore = 10000
        }
    }
    
    var body: some View {
        ZStack {
            Color("ColorGreen")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("You have achieve a new badge")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("ColorYellow"))
                    .padding()
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320)
                    .background(Color("ColorRedRMIT"))
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                VStack {
                    if (badge == .pro) {
                        Image("pro_badge")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 250)
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
                   
                    Text("Your high score has reached \(milestoneScore)")
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                    Button {
                        dismiss()
                    } label: {
                        Text("Accept".uppercased())
                            .frame(width: 200)
                    }
                    .modifier(ButtonModifier()
                    )
                }
            }
            .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 280, idealHeight: 300, maxHeight: 400, alignment: .center)
            .background(Color("ColorBlueRMIT"))
            .cornerRadius(20)
        }
        
    }
}

struct MilestoneView_Previews: PreviewProvider {
    static var previews: some View {
        MilestoneView(badge: Badge.master)
    }
}
