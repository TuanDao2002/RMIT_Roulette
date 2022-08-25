//
//  GameView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI
import AudioToolbox

// View for users to play the game
struct GameView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.dismiss) var dismiss
    private var userVM: UserViewModel
    
    @State private var atGameView = true
    
    @State private var isAnimating = false
    @State private var spinDegrees = 0.0
    @State private var rand = 0.0
    @State private var newAngle = 0.0

    @State var showRegister: Bool = false
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
    @Binding var resume: Bool
    
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
            checkWinning(newAngle: newAngle, statusAppear: &statusAppear, bonusMoney: &bonusMoney, bonusScore: &bonusScore, sectorsToBet: &sectorsToBet, resultStatus: &resultStatus, level: level, yourMoney: &yourMoney, highScore: &highScore, newBadge: &newBadge, userVM: userVM, showAchievement: &showAchievement, showingAlert: &showingAlert, alertContent: &alertContent)
        }
    }
    
    init(userVM: UserViewModel, level: Binding<Level>, resume: Binding<Bool>) {
        self.userVM = userVM
        self._level = level
        self._resume = resume
                
        if (self.resume) {
            _showRegister = State(initialValue: false)
        } else {
            _showRegister = State(initialValue: true)
        }
        
        if (!showRegister) {
            let currentUser = userVM.getCurrentUser()
            _highScore = State(initialValue: currentUser.highScore)
            
            if (currentUser.yourMoney <= 0) {
                userVM.updateCurrentUser(yourMoney: 1000, highScore: currentUser.highScore, badge: currentUser.badge)
            }
            
            _yourMoney = State(initialValue: userVM.getCurrentUser().yourMoney)
        }
        
        self.currentWorkItem = workItem()
    }
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        
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
            
            if (showAchievement) { // show MilestoneView when users reach an achievement
                MilestoneView(showAchievement: $showAchievement, badge: newBadge)
            }
            
            if (showRegister) { // show RegisterView when users need to register a username
                RegisterView(dismiss: dismiss, showRegister: $showRegister, userVM: userVM)
            }
        }
        .overlay(
            Button(action: {
                AudioServicesPlaySystemSound(1306)
                emptySound()
                playSound(sound: "background_music_menu", type: "mp3", loop: true)
                resume = true
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
                
                if (!showRegister) { // if the users exits the game after registering, the ResumeView will appear at MenuView
                    resume = true
                }
                
                emptySound()
            }
        }
        
        .alert(alertContent, isPresented: $showingAlert) {
            Button("Back to home", role: .destructive) {
                playSound(sound: "background_music_menu", type: "mp3", loop: true)
                resume = false
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
        
        .sheet(isPresented: $showInput) { // sheet to for users to chooses which values to bet
            ZStack {
                Color("ColorGreen").edgesIgnoringSafeArea(.all)
                VStack(spacing: 40) {
                    Spacer()
                    if (sectorsToBet.isEmpty) {
                        displayBetInstruction(numOfSectorsToBet: numOfSectorsToBet, level: level)
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
                        displayEachSector(sector: sectors[sectors.count - 1], handler: {validateSectorInput(sector: sectors[sectors.count - 1], sectorsToBet: &sectorsToBet, level: level)})
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(displaySectors(sectors: sectors), id: \.self) { sector in
                                displayEachSector(sector: sector, handler: {validateSectorInput(sector: sector, sectorsToBet: &sectorsToBet, level: level)})
                            }
                        }
                    }
                                
                    Button(action: {
                        AudioServicesPlaySystemSound(1306)

                        if (sectorsToBet.count < numOfSectorsToBet) { // alert users when the users does not choose enough values to bet
                            showingAlert = true
                            alertContent = "You must bet \(numOfSectorsToBet) values"
                            return
                        }
                        
                        playSound(sound: "roulette_spin", type: "mp3", loop: false)
                        
                        showInput = false
                        isAnimating = true
                        rand = Double.random(in: 1...360)
                        withAnimation(spinAnimation) { // trigger the spinning animation of roulette wheel
                            spinDegrees += 720.0 + rand - rand
                        }
                        newAngle = getAngle(angle: spinDegrees)
                        
                        currentWorkItem = workItem()
                        // wait until the roulette wheel stop spinning to check for winning and bonus money and scores
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
        GameView(userVM: UserViewModel(), level: .constant(Level.easy), resume: .constant(true))
    }
}
