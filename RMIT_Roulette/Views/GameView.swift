//
//  GameView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 15/08/2022.
//

import SwiftUI
enum ColorRoulette: String {
    case red = "RED"
    case black = "BLACK"
    case green = "GREEN"
    case empty
}
struct Sector: Equatable {
    let number: Int
    let color: ColorRoulette
}

struct GameView: View {
    @State private var isAnimating = false
        @State private var spinDegrees = 0.0
        @State private var rand = 0.0
        @State private var newAngle = 0.0
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
        var spinAnimation: Animation {
            Animation.easeOut(duration: 3.0)
                .repeatCount(1, autoreverses: false)
        }
        
        func getAngle(angle: Double) -> Double {
            let deg = 360 - angle.truncatingRemainder(dividingBy: 360)
            return deg
        }
        
        func sectorFromAngle(angle: Double) -> some View {
            var i = 0
            var sector: Sector = Sector(number: 0, color: .green)
            
            while sector == Sector(number: 0, color: .green) && i < sectors.count {
                let start: Double = halfSector * Double((i*2 + 1)) - halfSector
                let end: Double = halfSector * Double((i*2 + 3))
                
                if(angle > start && angle < end) {
                    sector = sectors[i]
                }
                i+=1
            }
            
            let numberValue = Text("\(sector.number) ").foregroundColor(.white).fontWeight(.bold)
            let fontColor: Color
            if (sector.color.rawValue == "RED") {
                fontColor = .red
            } else if (sector.color.rawValue == "BLACK"){
                fontColor = .black
            } else {
                fontColor = .green
            }
            
            let colorValue = Text(sector.color.rawValue).foregroundColor(fontColor).fontWeight(.bold)
            
            return numberValue + colorValue
        }
    
        func spinningText() -> some View {
            return Text("Spining...").fontWeight(.bold)
        }
        
        var body: some View {
            ZStack {
                Color("ColorGreen").edgesIgnoringSafeArea(.all)
                VStack {
                    if (self.isAnimating) {
                        spinningText()
                    } else {
                        sectorFromAngle(angle: newAngle)
                    }
                    
                    Image("red_arrow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Image("roulette_wheel")
                        .resizable()
                        .scaledToFit()
                        .rotationEffect(Angle(degrees: spinDegrees))
                        .frame(width: 245, height: 245, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Button(action: {
                        isAnimating = true
                        rand = Double.random(in: 1...360)
    //                    spinDegrees += 720.0 + rand
                        withAnimation(spinAnimation) {
                            spinDegrees += 720.0 + rand
                        }
                        newAngle = getAngle(angle: spinDegrees)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                            isAnimating = false

                        }
                        
                    }) {
                        Text("SPIN")
                            .frame(maxWidth: 500)
                    }
                    .modifier(ButtonModifier())
                    .padding(40)
                    .disabled(isAnimating == true)
                }
            }
    
        }}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewInterfaceOrientation(.portrait)
    }
}
