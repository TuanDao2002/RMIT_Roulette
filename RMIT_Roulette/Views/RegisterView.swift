//
//  RegisterView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 21/08/2022.
//

import SwiftUI

struct RegisterView: View {
    var dismiss: DismissAction

    @Binding var showRegister: Bool
    @State private var username: String = ""
    @State private var showError = false
    var userVM: UserViewModel
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 5) {
                Text("Enter a username")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("ColorYellow"))
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: 300)
                    .multilineTextAlignment(.center)
                    .padding()
                
                TextField("Username", text: $username)
                    .textFieldStyle(OvalTextFieldStyle())
                
                Text("Username must not be empty")
                    .fontWeight(.medium)
                    .foregroundColor(.red)
                    .opacity(showError ? 1 : 0)
                
                Button(action: {
                    if (username.isEmpty) {
                        showError = true
                        return
                    } else {
                        showError = false
                    }
                    
                    userVM.add(newUser: User(username: username, highScore: 0, badge: .empty))
                    self.showRegister = false
                }) {
                    Text("Register")
                }
                .modifier(ButtonModifier())
            }
        }
        
        .overlay(
            Button(action: {
                playSound(sound: "background_music_menu", type: "mp3", loop: true)
                dismiss()
            }) {
              Image(systemName: "house.circle")
                .foregroundColor(Color("ColorYellow"))
            }
            .modifier(IconModifier()),
            alignment: .top
        )
        
        .frame(minWidth: 250, idealWidth: 280, maxWidth: 320, minHeight: 200, idealHeight: 350, maxHeight: 370, alignment: .center)
        .cornerRadius(15)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
//        RegisterView(dismiss: DismissAction, showRegister: .constant(true), userVM: UserViewModel())
    }
}
