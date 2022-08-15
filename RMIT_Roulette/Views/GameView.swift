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
struct Sector: Equatable, Hashable {
    let number: Int
    let color: ColorRoulette
}

struct GameView: View {
    @State private var isAnimating = false
    @State private var spinDegrees = 0.0
    @State private var rand = 0.0
    @State private var newAngle = 0.0

    @State private var showInput = false
    @State private var numberValue: Int = 0
    @State private var colorValue: ColorRoulette = .green

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
        Animation.easeOut(duration: 3.0)
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
    
    func displaySectors(sectors: [Sector]) -> [Sector] {
        var customSector = sectors
        customSector.removeLast()
        return customSector.sorted(by: {$0.number < $1.number})
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
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Button(action: {
                    showInput = true
                }) {
                    Text("SPIN")
                        .frame(maxWidth: 250)
                }
                .padding(0)
                .modifier(ButtonModifier())
            }
        }.sheet(isPresented: $showInput) {
            Text("Choose a value to bet")
                .fontWeight(.bold)
            Image(systemName: "0.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.green)
                .padding()
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(displaySectors(sectors: sectors), id: \.self) { sector in
                    Image(systemName: "\(sector.number).circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(returnColor(sector: sector))
                }
            }
            
            Button(action: {
                showInput = false
                isAnimating = true
                rand = Double.random(in: 1...360)
                withAnimation(spinAnimation) {
                    spinDegrees += 720.0 + rand
                }
                newAngle = getAngle(angle: spinDegrees)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                    isAnimating = false
                }
                
            }) {
                Text("BET")
                    .frame(height: 50)
            }
            .modifier(ButtonModifier())
            .padding()
            .disabled(isAnimating == true)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .previewInterfaceOrientation(.portrait)
    }
}
