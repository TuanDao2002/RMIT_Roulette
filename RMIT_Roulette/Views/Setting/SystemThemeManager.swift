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
