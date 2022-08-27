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

// View for users to register a username
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
                    // not register new user if the username is empty or contains only whitespaces
                    if (username.trimmingCharacters(in: .whitespaces).isEmpty) {
                        showError = true
                        return
                    } else {
                        showError = false
                    }
                    
                    userVM.add(newUser: User(username: username, yourMoney: 1000, highScore: 0, badge: .empty))
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
