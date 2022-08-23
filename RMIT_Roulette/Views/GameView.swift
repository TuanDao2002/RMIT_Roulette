//
//  GameView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI
import AudioToolbox

struct GameView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    private var userVM: UserViewModel
    
    @State private var atGameView = true
    
    @State private var isAnimating = false
    @State private var spinDegrees = 0.0
    @State private var rand = 0.0
    @State private var newAngle = 0.0

    @State var showRegister = true
    @State var showAchievement = false
    @State private var newBadge: Badge = .empty
    @State private var showInput = false
    @State private var showInfo = false
    @State private var showingAlert = false
    @State private var alertContent = ""
    
    @State private var numberValue: Int = 0
    @State private var colorValue: ColorRoulette = .green
    
    @State private var sectorsToBet: [RouletteSector] = []
    @Binding var level: Level
    @State private var numOfSectorsToBet: Int = 0
    
    @State private var yourMoney: Int = 1000
    @State private var bonusMoney: Int = 0

    @State private var highScore: Int = 0
    @State private var bonusScore: Int = 0
    
    @State private var resultStatus: ResultStatus = .SM
    @State private var statusAppear = false
    
    @State private var currentWorkItem: DispatchWorkItem = DispatchWorkItem {}
    private func workItem() -> DispatchWorkItem {
        return DispatchWorkItem {
            isAnimating = false
            checkWinning(newAngle: newAngle)
        }
    }
    
    init(userVM: UserViewModel, level: Binding<Level>) {
        self.userVM = userVM
        self._level = level
        self.currentWorkItem = workItem()
    }
    
    let halfSector = 360.0 / 37.0 / 2.0
    let sectors: [RouletteSector] = RouletteSectorsViewModel.get()
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
    
    func returnColor(sector: RouletteSector) -> Color {
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
    
    func sectorFromAngle(angle: Double) -> RouletteSector {
        var i = 0
        var sector: RouletteSector = RouletteSector(number: -1, color: .empty)
        
        while sector == RouletteSector(number: -1, color: .empty) && i < sectors.count {
            let start: Double = halfSector * Double((i * 2 + 1)) - halfSector
            let end: Double = halfSector * Double((i * 2 + 3))
            
            if(angle > start && angle < end) {
                sector = sectors[i]
            }
            i += 1
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
        return HStack {
            Text("SPINING")
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.system(size: 25))
            DotView()
            DotView(delay: 0.2)
            DotView(delay: 0.4)
        }
    }
    
    func displayBetInstruction() -> some View {
        let inputText = Text("Choose \(numOfSectorsToBet) values to bet")
            .foregroundColor(Color("ColorYellow"))
            .font(.title)
            .fontWeight(.medium)
        
        var instructionText = Text("")
        if (level == Level.easy || level == Level.medium) {
            instructionText = Text("You can win if the result value is next to the value you choose")
                .foregroundColor(Color("ColorYellow"))
                .font(.title3)
                .fontWeight(.medium)
        }
        
        if (level == Level.hard) {
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
    
    func displaySectors(sectors: [RouletteSector]) -> [RouletteSector] {
        var customSector = sectors
        customSector.removeLast()
        return customSector.sorted(by: {$0.number < $1.number})
    }
    
    func displayEachSector(sector: RouletteSector) -> some View {
        return Button(action: {
            AudioServicesPlaySystemSound(1306)
            if (level == Level.easy) {
                if (sectorsToBet.count < 6 && !sectorsToBet.contains(sector)) {
                    sectorsToBet.append(sector)
                }
            } else if (level == Level.medium) {
                if (sectorsToBet.count < 4 && !sectorsToBet.contains(sector)) {
                    sectorsToBet.append(sector)
                }
            } else if (level == Level.hard) {
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

            if (level == Level.hard) {
                bonusScore = bonusScore * 5
            }
            
            bonusMoney = bonusMoney
            bonusScore = bonusScore
            playSound(sound: "coin_big_win", type: "wav", loop: false)
        } else if (level == Level.easy && sectorsToBet.filter{abs($0.number - resultSector.number) <= 1}.count > 0) {
            resultStatus = .SM
            bonusMoney = bonusMoney / 10
            bonusScore = bonusScore / 10
            playSound(sound: "coin_small_win", type: "wav", loop: false)
        } else if (level == Level.medium && sectorsToBet.filter{abs($0.number - resultSector.number) <= 1}.count > 0) {
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
        
        if (highScore >= 10000) {
            newBadge = .legend
        } else if (highScore >= 5000) {
            newBadge = .master
        } else if (highScore >= 1000) {
            newBadge = .pro
        }
        
        if (userVM.getCurrentUser().badge != newBadge) {
            showAchievement = true
        }
        
        userVM.updateCurrentUser(highScore: highScore, badge: newBadge)
        
        if (yourMoney <= 0) {
            yourMoney = 0
            showingAlert = true
            alertContent = "You lost all your money"
            emptySound()
            playSound(sound: "game_over", type: "wav", loop: false)
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
                        .fontWeight(.bold)
                        .modifier(ShowBonus(bonus: bonusMoney, statusAppear: statusAppear))
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
                        .fontWeight(.bold)
                        .modifier(ShowBonus(bonus: bonusScore, statusAppear: statusAppear))
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
                    
                    if (level == Level.easy) {
                        numOfSectorsToBet = 6
                    } else if (level == Level.medium) {
                        numOfSectorsToBet = 4
                    } else if (level == Level.hard) {
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
            .modifier(BlurViewWhenMilestoneAppear(showAchievement: showAchievement))
            .modifier(BlurViewWhenRegisterAppear(showRegister: showRegister))
            
            if (showAchievement) {
                MilestoneView(showAchievement: $showAchievement, badge: newBadge)
            }
            
            if (showRegister) {
                RegisterView(dismiss: dismiss, showRegister: $showRegister, userVM: userVM)
            }
        }
        .overlay(
            Button(action: {
                AudioServicesPlaySystemSound(1306)
                emptySound()
                playSound(sound: "background_music_menu", type: "mp3", loop: true)
                currentWorkItem.cancel()
                dismiss()
            }) {
              Image(systemName: "house.circle")
                .foregroundColor(Color("ColorYellow"))
            }
            .modifier(IconModifier())
            .modifier(BlurViewWhenMilestoneAppear(showAchievement: showAchievement))
            .modifier(BlurViewWhenRegisterAppear(showRegister: showRegister)),
            alignment: .topLeading
        )
        .overlay(
            Button(action: {
                AudioServicesPlaySystemSound(1306)
                self.showInfo = true
            }) {
              Image(systemName: "info.circle")
                .foregroundColor(Color("ColorYellow"))
            }
            .modifier(IconModifier())
            .modifier(BlurViewWhenMilestoneAppear(showAchievement: showAchievement))
            .modifier(BlurViewWhenRegisterAppear(showRegister: showRegister)),
            alignment: .topTrailing
        )
        
        .onAppear(perform: {
            playSound(sound: "background_music_casino", type: "mp3", loop: true)
        })
        
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                if (!atGameView) {
                    playSound(sound: "background_music_casino", type: "mp3", loop: true)
                    atGameView = true
                }
            } else if newPhase == .inactive || newPhase == .background {
                atGameView = false
                isAnimating = false
                newAngle = 0
                spinDegrees = 0
                currentWorkItem.cancel()
                emptySound()
            }
        }
        
        .alert(alertContent, isPresented: $showingAlert) {
            Button("Back to home", role: .destructive) {
                playSound(sound: "background_music_menu", type: "mp3", loop: true)
                dismiss()
            }
            
            Button("Try again", role: .cancel) {
                yourMoney = 1000
                playSound(sound: "background_music_casino", type: "mp3", loop: true)
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
                            spinDegrees += 720.0 + rand - rand
                        }
                        newAngle = getAngle(angle: spinDegrees)
                        
                        currentWorkItem = workItem()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.9, execute: currentWorkItem)
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
        GameView(userVM: UserViewModel(), level: .constant(Level.easy))
    }
}
