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

// View to change the theme mode and difficulty level
struct SettingView: View {
    
    @Binding var isDarkMode: Bool
    @Binding var isUseSystem: Bool
    @Binding var level: Level
        
    var body: some View {
        NavigationView {
            // toggles to change the theme to dark mode or light mode or use the default theme mode of the device's system
            Form {
                Section(header: Text("Display Settings")) {
                    Toggle(isOn: $isDarkMode, label: {
                        Text("Dark mode")
                    }).onChange(of: isDarkMode, perform: {_ in
                        SystemThemeManager.shared.handleTheme(darkMode: isDarkMode, system: isUseSystem)
                    })
                    
                    Toggle(isOn: $isUseSystem, label: {
                        Text("Use system setting")
                    }).onChange(of: isUseSystem, perform: {_ in
                        SystemThemeManager.shared.handleTheme(darkMode: isDarkMode, system: isUseSystem)
                    })
                }
                
                // choose a difficulty level to play
                Section(header: Text("Difficulty level")) {
                    Picker(selection: $level, label: Text("Select an option:")) {
                        Text("Easy").tag(Level.easy)
                        Text("Medium").tag(Level.medium)
                        Text("Hard").tag(Level.hard)
                    }
                    .labelsHidden()
                    .pickerStyle(.inline)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isDarkMode: .constant(false), isUseSystem: .constant(false), level: .constant(Level.empty))
    }
}
