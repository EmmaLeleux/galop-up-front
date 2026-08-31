//
//  OnBoardingLevelNotBeginnerView.swift
//  Galop'Up
//
//  Created by Emma on 17/08/2026.
//

import SwiftUI

struct OnBoardingLevelNotBeginnerView: View {
    var onComplete: () -> Void
    @Environment(AuthService.self) var authService

    var body: some View {
        VStack{
            ConversationComponentView(text: "Tu as déjà des connaissances ? Et si on évaluait ton niveau ensemble ?")
            Image(.galopinHeureux)
                .resizable()
                .mascotteSize()
                .padding(.bottom, 15)
            
            
            Button("Evaluer mon niveau (10 questions)") {
                onComplete()
            }
            .CustomButton()
            
            Button("Passer et choisir mon niveau") {
               
            }
            .foregroundStyle(.customBrown)
        }
    }
}
