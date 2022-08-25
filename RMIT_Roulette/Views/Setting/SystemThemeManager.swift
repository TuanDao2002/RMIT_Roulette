//
//  SystemThemeManager.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 22/08/2022.
//

import Foundation
import UIKit

// a class to set the theme based on user's input
class SystemThemeManager {
    
    static let shared = SystemThemeManager()
    
    private init() {
        
    }
    
    func handleTheme(darkMode: Bool, system: Bool) {
        
        guard !system else {
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
            return
        }
        
        
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = darkMode ? .dark : .light
    }
    
}
