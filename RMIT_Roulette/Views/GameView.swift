//
//  GameView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI
import AudioToolbox
enum ColorRoulette: String {
    case red = "RED"
    case black = "BLACK"
    case green = "GREEN"
    case empty
}

enum ResultStatus: String {
    case SM = "GOOD JOB 😇"
    case BW = "NICE BET 🥳"
    case LO = "UNLUCKY 😢"
}

struct Sector: Equatable, Hashable {
    var number: Int
    let color: ColorRoulette
}

struct GameView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    
    @State private var isAnimating = false
    @State private var spinDegrees = 0.0
    @State private var rand = 0.0
    @State private var newAngle = 0.0

    @State private var showInput = false
    @State private var showInfo = false
    @State private var showingAlert = false
    @State private var alertContent = ""
    
    @State private var numberValue: Int = 0
    @State private var colorValue: ColorRoulette = .green
    
    @State private var sectorsToBet: [Sector] = []
    @AppStorage("level") var level: String = "Medium"
    @State private var numOfSectorsToBet: Int = 0
    
    @State private var yourMoney: Int = 1000
    @State private var bonusMoney: Int = 0

    @State private var highScore: Int = 0
    @State private var bonusScore: Int = 0
//    @AppStorage("yourMoney") var yourMoney: Int = 1000
//    @AppStorage("highScore") var highScore: Int = 0

    @State private var resultStatus: ResultStatus = .SM
    @State private var statusAppear = false
    
    let halfSector = 360.0 / 37.0 / 2.0
    let sectors: [Sector] = [Sector(number: 32, color: .red),
                             Sector(number: 15, color: .black),
                             Sector(number: 19, color: .red),
                             Sector(number: 4, color: .black),
                             Sector(number: 21, color: .red),
                             Sector(number: 2, color: .black),
                             Sector(number: 25, color: .red),
                             Sector(number: 17, color: .black),
                             Sector(number: 34, color: .red),
                             Sector(number: 6, color: .black),
                             Sector(number: 27, color: .red),
                             Sector(number: 13, color: .black),
                             Sector(number: 36, color: .red),
                             Sector(number: 11, color: .black),
                             Sector(number: 30, color: .red),
                             Sector(number: 8, color: .black),
                             Sector(number: 23, color: .red),
                             Sector(number: 10, color: .black),
                             Sector(number: 5, color: .red),
                             Sector(number: 24, color: .black),
                             Sector(number: 16, color: .red),
                             Sector(number: 33, color: .black),
                             Sector(number: 1, color: .red),
                             Sector(number: 20, color: .black),
                             Sector(number: 14, color: .red),
                             Sector(number: 31, color: .black),
                             Sector(number: 9, color: .red),
                             Sector(number: 22, color: .black),
                             Sector(number: 18, color: .red),
                             Sector(number: 29, color: .black),
                             Sector(number: 7, color: .red),
                             Sector(number: 28, color: .black),
                             Sector(number: 12, color: .red),
                             Sector(number: 35, color: .black),
                             Sector(number: 3, color: .red),
                             Sector(number: 26, color: .black),
                             Sector(number: 0, color: .green)]
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var spinAnimation: Animation {
        Animation.easeOut(duration: 5.0)
            .repeatCount(1, autoreverses: false)
    }
    
    func getAngle(angle: Double) -> Double {
        let deg = 360 - angle.truncatingRemainder(dividingBy: 360)
        return deg
    }
    
    func returnColor(sector: Sector) -> Color {
        let fontColor: Color
        if (sector.color.rawValue == "RED") {
            fontColor = .red
        } else if (sector.color.rawValue == "BLACK"){
            fontColor = .black
        } else {
            fontColor = .green
        }
        
        return fontColor
    }
    
    func sectorFromAngle(angle: Double) -> Sector {
        var i = 0
        var sector: Sector = Sector(number: -1, color: .empty)
        
        while sector == Sector(number: -1, color: .empty) && i < sectors.count {
            let start: Double = halfSector * Double((i*2 + 1)) - halfSector
            let end: Double = halfSector * Double((i*2 + 3))
            
            if(angle > start && angle < end) {
                sector = sectors[i]
            }
            i+=1
        }
        
        return sector
    }
    
    func displayResultSector(angle: Double) -> some View {
        var sector = sectorFromAngle(angle: angle)
        
        if (sector.number == -1 && sector.color == .empty) {
            sector = sectors[sectors.count - 1]
        }
        
        let numberValue = Text("\(sector.number) ")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.system(size: 25))
        
        let colorValue = Text(sector.color.rawValue)
            .foregroundColor(returnColor(sector: sector))
                            .fontWeight(.bold)
                            .font(.system(size: 25))

        return numberValue + colorValue
    }

    func spinningText() -> some View {
        return Text("SPINING...")
                    .fontWeight(.bold)
                    .font(.system(size: 25))
    }
    
    func displayBetInstruction() -> some View {
        let inputText = Text("Choose \(numOfSectorsToBet) values to bet")
            .foregroundColor(Color("ColorYellow"))
            .font(.title)
            .fontWeight(.medium)
        
        var instructionText = Text("")
        if (level == "Easy" || level == "Medium") {
            instructionText = Text("You can win if the result value is next to the value you choose")
                .foregroundColor(Color("ColorYellow"))
                .font(.title3)
                .fontWeight(.medium)
        }
        
        if (level == "Hard") {
            instructionText = Text("You can only win if the result value is 1 of 2 values you choose")
                .foregroundColor(Color("ColorYellow"))
                .font(.title3)
                .fontWeight(.medium)
        }
        
        return VStack(alignment: .center) {
            inputText
            instructionText
        }
        .multilineTextAlignment(.center)
        .padding()
    }
    
    func displaySectors(sectors: [Sector]) -> [Sector] {
        var customSector = sectors
        customSector.removeLast()
        return customSector.sorted(by: {$0.number < $1.number})
    }
    
    func displayEachSector(sector: Sector) -> some View {
        return Button(action: {
            AudioServicesPlaySystemSound(1306)
            if (level == "Easy") {
                if (sectorsToBet.count < 6 && !sectorsToBet.contains(sector)) {
                    sectorsToBet.append(sector)
                }
            } else if (level == "Medium") {
                if (sectorsToBet.count < 4 && !sectorsToBet.contains(sector)) {
                    sectorsToBet.append(sector)
                }
            } else if (level == "Hard") {
                if (sectorsToBet.count < 2 && !sectorsToBet.contains(sector)) {
                    sectorsToBet.append(sector)
                }
            }
        }) {
            Image(systemName: "\(sector.number).circle.fill")
                .font(.largeTitle)
                .foregroundColor(returnColor(sector: sector))
                .background(.white)
                .cornerRadius(200)
        }
    }
    
    func checkWinning(newAngle: Double) {
        statusAppear = true
        let resultSector = sectorFromAngle(angle: newAngle)

        bonusMoney = 1000
        bonusScore = 100
        
        if (sectorsToBet.filter{$0.number == resultSector.number}.count > 0) {
            resultStatus = .BW

            if (level == "Hard") {
                bonusMoney = bonusMoney * 2
                bonusScore = bonusScore * 2
            }
            
            bonusMoney = bonusMoney
            bonusScore = bonusScore
            playSound(sound: "coin_big_win", type: "wav", loop: false)
        } else if (level == "Easy" && sectorsToBet.filter{abs($0.number - resultSector.number) <= 1}.count > 0) {
            resultStatus = .SM
            bonusMoney = bonusMoney / 10
            bonusScore = bonusScore / 10
            playSound(sound: "coin_small_win", type: "wav", loop: false)
        } else if (level == "Medium" && sectorsToBet.filter{abs($0.number - resultSector.number) <= 1}.count > 0) {
            resultStatus = .SM
            bonusMoney = bonusMoney / 5
            bonusScore = bonusScore / 5
            playSound(sound: "coin_small_win", type: "wav", loop: false)
        } else if (sectorsToBet.filter{$0.number == resultSector.number}.count == 0) {
            resultStatus = .LO
            bonusMoney = -bonusMoney / 10
            bonusScore = 0
            playSound(sound: "coin_lose", type: "wav", loop: false)
        }
        
        yourMoney += bonusMoney
        highScore += bonusScore
        
        if (yourMoney <= 0) {
            yourMoney = 0
            showingAlert = true
            alertContent = "You lost all your money"
        }
    }
    
    var body: some View {
        ZStack {
            Color("ColorGreen").edgesIgnoringSafeArea(.all)
            VStack {
                Image("roulette_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 900, alignment: .center)
                VStack(spacing: 3) {
                    Text("\(resultStatus.rawValue)")
                        .font(.title)
                        .foregroundColor(bonusMoney > 0 ? .green : .red)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .opacity(statusAppear ? 1 : 0)
                        .onChange(of: statusAppear) {newValue in
                            withAnimation(Animation.easeInOut(duration: 5)) {
                                statusAppear = false
                            }
                        }
                        .multilineTextAlignment(.center)
                    
                    Text(bonusMoney > 0 ? "+\(bonusMoney)" : "\(bonusMoney)")
                        .foregroundColor(bonusMoney > 0 ? .green : .red)
                        .fontWeight(.bold)
                        .frame(maxWidth: 250, alignment: .trailing)
                        .opacity(statusAppear ? 1 : 0)
                        .onChange(of: statusAppear) {newValue in
                            withAnimation(Animation.easeInOut(duration: 5)) {
                                statusAppear = false
                            }
                        }
                    
                    HStack {
                        Text("Your money:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(yourMoney)")
                            .fontWeight(.bold)
                    }.modifier(StatusTextFieldModifier())
                    
                    Text("+\(bonusScore)")
                        .foregroundColor(.green)
                        .fontWeight(.bold)
                        .frame(maxWidth: 250, alignment: .trailing)
                        .opacity(bonusScore > 0 && statusAppear ? 1 : 0)
                        .onChange(of: statusAppear) {newValue in
                            withAnimation(Animation.easeInOut(duration: 5)) {
                                statusAppear = false
                            }
                        }
                    
                    HStack {
                        Text("High score:")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(highScore)")
                            .fontWeight(.bold)
                    }.modifier(StatusTextFieldModifier())
                }
                
                if (self.isAnimating) {
                    spinningText()
                } else {
                    displayResultSector(angle: newAngle)
                }
                
                Image("red_arrow")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                Image("roulette_wheel")
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(Angle(degrees: spinDegrees))
                    .frame(minWidth: 280, minHeight: 280, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    AudioServicesPlaySystemSound(1306)

                    showInput = true
                    sectorsToBet = []
                    
                    if (level == "Easy") {
                        numOfSectorsToBet = 6
                    } else if (level == "Medium") {
                        numOfSectorsToBet = 4
                    } else if (level == "Hard") {
                        numOfSectorsToBet = 2
                    }
                }) {
                    Text("SPIN")
                        .fontWeight(.medium)
                        .frame(maxWidth: 250)
                }
                .disabled(isAnimating == true)
                .modifier(ButtonModifier())
            }
        }
        .overlay(
            Button(action: {
                AudioServicesPlaySystemSound(1306)
                emptySound()
                playSound(sound: "background_music_menu", type: "mp3", loop: true)
                dismiss()
            }) {
              Image(systemName: "house.circle")
                .foregroundColor(Color("ColorYellow"))
            }.modifier(IconModifier()), alignment: .topLeading
        )
        .overlay(
            Button(action: {
                AudioServicesPlaySystemSound(1306)
                self.showInfo = true
            }) {
              Image(systemName: "info.circle")
                .foregroundColor(Color("ColorYellow"))
            }.modifier(IconModifier()), alignment: .topTrailing
        )
        
        .onAppear(perform: {
            playSound(sound: "background_music_casino", type: "mp3", loop: true)
        })
//
//        .onDisappear(perform: {
//            emptySound()
//        })
        
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                playSound(sound: "background_music_casino", type: "mp3", loop: true)
            } else if newPhase == .inactive || newPhase == .background {
                emptySound()
            }
        }
        
        .alert(alertContent, isPresented: $showingAlert) {
            Button("Back to home", role: .destructive) {
                dismiss()
            }
            
            Button("Try again", role: .cancel) {
                yourMoney = 1000
            }
        }
        
        .sheet(isPresented: $showInfo) {
            HowToPlay(backToMenu: false)
        }
        
        .sheet(isPresented: $showInput) {
            ZStack {
                Color("ColorGreen").edgesIgnoringSafeArea(.all)
                VStack(spacing: 40) {
                    Spacer()
                    if (sectorsToBet.isEmpty) {
                        displayBetInstruction()
                    } else {
                        HStack {
                            Text("You bet")
                                .foregroundColor(Color("ColorYellow"))
                                .font(.title)
                                .fontWeight(.medium)
                            ForEach(sectorsToBet, id: \.self) {sector in
                                Button(action: {
                                    AudioServicesPlaySystemSound(1306)
                                    sectorsToBet = sectorsToBet.filter { $0 != sector }
                                }) {
                                    Image(systemName: "\(sector.number).circle.fill")
                                        .font(.largeTitle)
                                        .foregroundColor(returnColor(sector: sector))
                                        .background(.white)
                                        .cornerRadius(200)
                                }
                            }
                        }.padding()
                    }
                    
                    VStack {
                        displayEachSector(sector: sectors[sectors.count - 1])
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(displaySectors(sectors: sectors), id: \.self) { sector in
                                displayEachSector(sector: sector)
                            }
                        }
                    }
                                
                    Button(action: {
                        AudioServicesPlaySystemSound(1306)

                        if (sectorsToBet.count < numOfSectorsToBet) {
                            showingAlert = true
                            alertContent = "You must bet \(numOfSectorsToBet) values"
                            return
                        }
                        
                        playSound(sound: "roulette_spin", type: "mp3", loop: false)
                        
                        showInput = false
                        isAnimating = true
                        rand = Double.random(in: 1...360)
                        withAnimation(spinAnimation) {
                            spinDegrees += 720.0 + rand
                        }
                        newAngle = getAngle(angle: spinDegrees)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.9) {
                            isAnimating = false
                            checkWinning(newAngle: newAngle)
                        }
                    }){
                        Text("BET")
                            .fontWeight(.medium)
                            .frame(height: 50)
                    }
                    .alert(alertContent, isPresented: $showingAlert) {
                        Button("OK", role: .cancel){}
                    }
                    .modifier(ButtonModifier())
                    .padding()
                }
            }
            .overlay(
                Button(action: {
                    AudioServicesPlaySystemSound(1306)
                    showInput = false
                }) {
                  Image(systemName: "xmark.circle")
                    .font(.title)
                }
                    .foregroundColor(Color("ColorYellow"))
                .padding(.top, 30)
                .padding(.trailing, 20), alignment: .topTrailing
            )
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .preferredColorScheme(.light)
    }
}
