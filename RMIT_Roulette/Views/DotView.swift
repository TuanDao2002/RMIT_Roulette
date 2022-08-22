//
//  DotView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 19/08/2022.
//

import SwiftUI

struct DotView: View {
    @State var delay: Double = 0
    @State var scale: CGFloat = 0.5
    
    var body: some View {
        Circle()
            .frame(width: 15, height: 15)
            .scaleEffect(scale)
            .foregroundColor(.black)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 0.6).repeatForever().delay(delay)) {
                    self.scale = 1
                }
            }
    }
}

struct DotView_Previews: PreviewProvider {
    static var previews: some View {
        DotView()
    }
}
