//
//  OnBoardingLevelBeginnerView.swift
//  Galop'Up
//
//  Created by Emma on 17/08/2026.
//

import SwiftUI

struct OnBoardingLevelBeginnerView: View {
    var onComplete: () -> Void
    @Environment(AuthService.self) var authService

    var body: some View {
        VStack{
            ConversationComponentView(text: "Tu débute ? Commençons par quelques questions simples dans ce cas !")
            Image(.galopinHeureux)
                .resizable()
                .mascotteSize()
                .padding(.bottom, 15)
            
            
            Button("Démarrer le quiz (3 questions)") {
                onComplete()
            }
            .CustomButton()
            
            Button("Passer") {
                Task{
                    try await authService.updateUser(userInfos: UserInfoToUpdate(level: .GALOP1))

                }
            }
            .foregroundStyle(.customBrown)
        }
    }
}
