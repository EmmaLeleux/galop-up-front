//
//  OnBoardingUsername.swift
//  Galop'Up
//
//  Created by Emma on 07/06/2026.
//

import SwiftUI

struct OnBoardingUsername: View {
    @FocusState var isFocused
    @State var username: String = ""
    @Environment(AuthService.self) var authService

    var onComplete: () -> Void
    var body: some View {
        VStack{
            
            ConversationComponentView(text: "Bienvenue ! Je suis Pixel, ton partenaire de révision. Comment on t'appelle aux écuries ?")
            Image(.galopinHeureux)
                .resizable()
                .mascotteSize()
                .padding(.bottom, 15)
            
            CustomTextFieldComponent(text: $username, placehorder: "Username", isFocused: $isFocused)
                .padding(.vertical, 15)
            
            
            if username != "" {
                Button("Suivant") {
                    Task{
                        do{
                            try await authService.updateUser(userInfos: UserInfoToUpdate(username: username))
                            onComplete()
                        }
                        catch{
                            print(error)
                        }
                    }
                    
                }
                .CustomButton()
            }
            else{
                Button("Suivant") {
                    
                }
                .CustomButton(backgroundColor: .gray)
            }
            
        }
        

    }
}

