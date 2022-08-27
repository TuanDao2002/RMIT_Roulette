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

// a view to display instructions on how to play and every difficulty levels
struct HowToPlay: View {
    @Environment(\.dismiss) var dismiss
    private var backToMenu = false

    init(backToMenu: Bool) {
        self.backToMenu = backToMenu
    }
    
    var body: some View {
        ZStack {
            Color("ColorGreen").edgesIgnoringSafeArea(.all)
                VStack {
                    Image("roulette_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 400, maxHeight: 200, alignment: .center)
                    Form {
                        Section(header: Text("How To Play")
                                            .foregroundColor(Color("SectionHeaderColor"))
                                            .font(.title)
                                            .fontWeight(.bold)) {
                            Text("1. Tap at the SPIN button")
                            Text("2. Then a sheet appears and displays some values to bet")
                            Text("3. Choose some values to bet")
                            Text("4. Tap at the BET button")
                            Text("5. The roulette wheel will spin and when it stops, it displays a result value")
                            Text("6. If one of your bet values is matched with the result value, you will gain more money and score")
                            Text("7. Otherwise, you will lose money, but your score still remains")
                        }
                        .listRowBackground(Color("ColorYellow"))
                        
                        Section(header: Text("Easy mode")
                                            .foregroundColor(Color("SectionHeaderColor"))
                                            .font(.title)
                                            .fontWeight(.bold)) {
                            Text("In easy mode, you can bet 6 values")
                            Text("You will win if one of them is matched with the result value, your money will increase by 1000 and high score increases by 100")
                            Text("You can also win if one of them is next to the result value, your money will increase by 100 and high score increases by 10")
                            Text("If none of them is matched with the result value, your money will decrease by 100 and your score will not increase")
                        }
                        .listRowBackground(Color("ColorYellow"))
                        
                        Section(header: Text("Medium mode")
                                            .foregroundColor(Color("SectionHeaderColor"))
                                            .font(.title)
                                            .fontWeight(.bold)) {
                            Text("In medium mode, you can bet 4 values")
                            Text("You will win if one of them is matched with the result value, your money will increase by 1000 and high score increases by 100")
                            Text("You can also win if one of them is next to the result value, your money will increase by 200 and high score increases by 20")
                            Text("If none of them is matched with the result value, your money will decrease by 100 and your score will not increase")
                        }
                        .listRowBackground(Color("ColorYellow"))
                        
                        Section(header: Text("Hard mode")
                                            .foregroundColor(Color("SectionHeaderColor"))
                                            .font(.title)
                                            .fontWeight(.bold)) {
                            Text("In hard mode, you can bet 2 values")
                            Text("You will win if one of them is matched with the result value, your money will increase by 1000 and high score increases by 500")
                            Text("If none of them is matched with the result value, your money will decrease by 100 and your score will not increase")
                        }
                        .listRowBackground(Color("ColorYellow"))
                        
                        Section(header: Text("Achievement badges")
                                            .foregroundColor(Color("SectionHeaderColor"))
                                            .font(.title)
                                            .fontWeight(.bold)) {
                            Text("To achieve Pro badge, you need to reach 1000 points")
                            Text("To achieve Master badge, you need to reach 5000 points")
                            Text("To achieve Legend badge, you need to reach 10000 points")

                        }
                        .listRowBackground(Color("ColorYellow"))
                    }
                    .foregroundColor(.black)
                    .padding(.bottom, backToMenu ? UIDevice.current.userInterfaceIdiom == .phone ? 30 : 65 : 0)
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
                }
                .modifier(AddBottomBarModifier())
                .opacity(backToMenu ? 1 : 0),
                alignment: .bottom
        )
        
        .overlay(
            Button(action: {
                AudioServicesPlaySystemSound(1306)
                dismiss()
            }) {
                Image(systemName: "xmark.circle")
                    .font(.largeTitle)
            }
            .modifier(AddXMarkModifier())
            .opacity(backToMenu ? 0 : 1),
            alignment: .topTrailing
        )
    }
}

struct HowToPlay_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlay(backToMenu: true)
    }
}
