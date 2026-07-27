//
//  OnBoardingLevelView.swift
//  Galop'Up
//
//  Created by Emma on 08/06/2026.
//

import SwiftUI

struct OnBoardingLevelView: View {
    var onComplete: () -> Void
    @Environment(AuthService.self) var authService

    var body: some View {
        VStack{
            ConversationComponentView(text: "Quel est ton niveau ?")
            Image(.galopinHeureux)
                .resizable()
                .mascotteSize()
                .padding(.bottom, 15)
            
            
            Button("Je débute") {
                onComplete()
            }
            .CustomButton()
            
            Button("J’ai déjà des connaissances") {
               // onComplete()
                Task{
                    
                    
                    try await authService.logout()
                }
            }
            .CustomButton()
        }
    }
}


