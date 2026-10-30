//
//  OnBoardingLevelView.swift
//  Galop'Up
//
//  Created by Emma on 08/06/2026.
//

import SwiftUI

struct OnBoardingLevelView: View {
    var onCompleteBeginner: () -> Void
    var onCompleteNotBeginner: () -> Void
    @Environment(AuthViewModel.self) var authVM

    var body: some View {
        VStack{
            ConversationComponentView(text: "Quel est ton niveau ?")
            Image(.galopinHeureux)
                .resizable()
                .mascotteSize()
                .padding(.bottom, 15)
            
            
            Button("Je débute") {
                onCompleteBeginner()
            }
            .CustomButton()
            
            Button("J’ai déjà des connaissances") {
                onCompleteNotBeginner()
                Task{
                    
                    
                    try await authVM.logout()
                }
            }
            .CustomButton()
        }
    }
}


