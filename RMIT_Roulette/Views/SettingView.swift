//
//  SettingView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 22/08/2022.
//

import SwiftUI

struct SettingView: View {
    
    @Binding var isDarkMode:Bool
    @Binding var isUseSystem:Bool
    
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
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(isDarkMode: .constant(false), isUseSystem: .constant(false))
    }
}
