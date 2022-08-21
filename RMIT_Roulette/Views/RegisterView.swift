//
//  RegisterView.swift
//  RMIT_Roulette
//
//  Created by Tuan Dao on 21/08/2022.
//

import SwiftUI

struct RegisterView: View {
    @Binding var showRegister: Bool
    @State private var username: String = ""
    var userVM: UserViewModel
    
    var body: some View {
        ZStack {
            Color("ColorBlue")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Enter a username")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color("ColorYellow"))
                    .padding()
                    .frame(minWidth: 100, idealWidth: 200, maxWidth: 300)
                    .multilineTextAlignment(.center)
                
                TextField("Username", text: $username)
                    .textFieldStyle(OvalTextFieldStyle())
                
                Button(action: {
                    userVM.add(newUser: User(username: username, highScore: 0, badge: .empty))
                    self.showRegister = false
                }) {
                    Text("Register")
                }
                .modifier(ButtonModifier())
            }
            .padding()
        }
        .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 150, idealHeight: 170, maxHeight: 270, alignment: .center)
        .cornerRadius(15)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(showRegister: .constant(true), userVM: UserViewModel())
    }
}
