//
//  connexion.swift
//  Galop'Up
//
//  Created by Emma on 22/05/2026.
//

import SwiftUI

struct ConnexionView: View {
    @Environment(AuthService.self) var authService
    @State var email: String = ""
    @State var password: String = ""
    @FocusState.Binding var isFocused: Bool
    var body: some View {
        
        CustomTextFieldComponent(text: $email, placehorder: "Email", isFocused: $isFocused)
        
        VStack(alignment: .trailing){
            CustomTextFieldComponent(text: $password, placehorder: "Mot de passe", isSecured: true, isFocused: $isFocused)
            
            Text("mot de passe oublié ?")
                .font(.custom("Lato-Regular", size: 12))
                .foregroundStyle(.customBrown)
        }
        
        Button(action:{
            Task{
                try await authService.login(email: email, password: password)
            }
            
        }, label: {
            
            Text("Se connecter")
                .CustomButton()
            
        })
    }
}


