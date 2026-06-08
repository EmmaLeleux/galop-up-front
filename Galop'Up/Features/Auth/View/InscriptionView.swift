//
//  InscriptionView.swift
//  Galop'Up
//
//  Created by Emma on 22/05/2026.
//

import SwiftUI

struct InscriptionView: View {
    @Environment(AuthService.self) var authService
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @FocusState.Binding var isFocused: Bool
    var body: some View {
        
        CustomTextFieldComponent(text: $email, placehorder: "Email", isFocused: $isFocused)
    
            CustomTextFieldComponent(text: $password, placehorder: "Mot de passe", isSecured: true, isFocused: $isFocused)
        
        CustomTextFieldComponent(text: $confirmPassword, placehorder: "Confirmer le mot de passe", isSecured: true, isFocused: $isFocused)
            
        
        Button(action:{
            Task{
                try await authService.register(email: email, password: password, confirmPassword: confirmPassword)

            }
        }, label: {
            
            Text("S'inscrire")
                .CustomButton()
            
        })
    }
}

