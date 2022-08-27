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

// View to display 3 dots for waiting animation while the roulette wheel is spinning
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
