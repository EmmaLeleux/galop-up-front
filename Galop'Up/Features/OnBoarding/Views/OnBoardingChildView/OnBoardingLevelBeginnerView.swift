//
//  OnBoardingLevelBeginnerView.swift
//  Galop'Up
//
//  Created by Emma on 17/08/2026.
//

import SwiftUI

struct OnBoardingLevelBeginnerView: View {
    var onComplete: () -> Void
    @Environment(AuthViewModel.self) var authVM

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
                    try await authVM.updateUser(userInfos: UserInfoToUpdate(level: .GALOP1))

                }
            }
            .foregroundStyle(.customBrown)
        }
    }
}
