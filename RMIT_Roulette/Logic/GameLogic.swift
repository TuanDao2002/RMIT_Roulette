//
//  GameLogic.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 24/08/2022.
//

import Foundation
import SwiftUI
import AudioToolbox
import AVFoundation

let halfSector = 360.0 / 37.0 / 2.0
let sectors: [RouletteSector] = RouletteSectorsViewModel.get()

// spin animation for the roulette wheel
var spinAnimation: Animation {
    Animation.easeOut(duration: 5.0)
        .repeatCount(1, autoreverses: false)
}

// re-calculate the angle to get the result sector
func getAngle(angle: Double) -> Double {
    let deg = 360 - angle.truncatingRemainder(dividingBy: 360)
    return deg
}

// set the color of the input sector
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

// get the result sector based on the spinned angle of the roulette wheel
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

// display the result sector on the Game View
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

// the animation text indicates the roulette is spinning
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

// display the instructions on how to bet based on the difficulty level
func displayBetInstruction(numOfSectorsToBet: Int, level: Level) -> some View {
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

// display all the sectors user can bet
func displaySectors(sectors: [RouletteSector]) -> [RouletteSector] {
    var customSector = sectors
    customSector.removeLast()
    return customSector.sorted(by: {$0.number < $1.number})
}

// validate the sectors users bet
func validateSectorInput(sector: RouletteSector, sectorsToBet: inout [RouletteSector], level: Level) {
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
}

// display each sector user can bet and allow them to choose a sector to bet
func displayEachSector(sector: RouletteSector, handler: @escaping () -> Void) -> some View {
    return Button(action: {
        AudioServicesPlaySystemSound(1306)
        handler()
    }) {
        Image(systemName: "\(sector.number).circle.fill")
            .font(.largeTitle)
            .foregroundColor(returnColor(sector: sector))
            .background(.white)
            .cornerRadius(200)
    }
}

// function to check if the users win and bonuse money and score users can gain
func checkWinning(newAngle: Double, statusAppear: inout Bool, bonusMoney: inout Int, bonusScore: inout Int, sectorsToBet: inout [RouletteSector], resultStatus: inout ResultStatus, level: Level, yourMoney: inout Int, highScore: inout Int, newBadge: inout Badge, userVM: UserViewModel, showAchievement: inout Bool, showingAlert: inout Bool, alertContent: inout String) {
    statusAppear = true
    let resultSector = sectorFromAngle(angle: newAngle)

    bonusMoney = 1000
    bonusScore = 100

    if (sectorsToBet.filter{$0.number == resultSector.number}.count > 0) {
        resultStatus = .BW

        if (level == Level.hard) {
            bonusScore = bonusScore * 5
        }

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

    userVM.updateCurrentUser(yourMoney: yourMoney, highScore: highScore, badge: newBadge)

    if (yourMoney <= 0) {
        yourMoney = 0
        showingAlert = true
        alertContent = "You lost all your money"
        emptySound()
        playSound(sound: "game_over", type: "wav", loop: false)
    }
}
