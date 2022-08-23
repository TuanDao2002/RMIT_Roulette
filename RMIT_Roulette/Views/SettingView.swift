//
//  SettingView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 22/08/2022.
//

import SwiftUI

struct SettingView: View {
    
    @Binding var isDarkMode: Bool
    @Binding var isUseSystem: Bool
    @Binding var level: Level
        
    var body: some View {
        NavigationView {
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
                
                Section(header: Text("Difficulty level")) {
                    Picker(selection: $level, label: Text("Select an option:")) {
                        Text("Easy").tag(Level.easy)
                        Text("Medium").tag(Level.medium)
                        Text("Hard").tag(Level.hard)
                    }
                    .pickerStyle(.inline)
                }
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isDarkMode: .constant(false), isUseSystem: .constant(false), level: .constant(Level.empty))
    }
}
