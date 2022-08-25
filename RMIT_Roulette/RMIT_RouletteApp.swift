//
//  RMIT_RouletteApp.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 14/08/2022.
//

import SwiftUI

@main
struct RMIT_RouletteApp: App {
    var userVM = UserViewModel()
    var body: some Scene {
        WindowGroup {
            MenuView()
                .environmentObject(userVM)
        }
    }
}
