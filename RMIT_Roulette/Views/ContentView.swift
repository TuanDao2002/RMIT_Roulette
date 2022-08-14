//
//  ContentView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 14/08/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Color("ColorGreen")
            .ignoresSafeArea()
            .overlay(
                Image("roulette_wheel")
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
