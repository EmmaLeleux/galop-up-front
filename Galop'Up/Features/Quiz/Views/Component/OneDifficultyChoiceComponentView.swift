//
//  One difficultyChoiceComponentView.swift
//  Galop'Up
//
//  Created by Emma on 27/10/2026.
//

import SwiftUI

struct OneDifficultyChoiceComponentView: View {
    var difficulty : QuizSessionDifficultyEnum
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(difficulty.rawValue)
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.bold)
                    .foregroundStyle(.customBrown)
                Text(difficulty.description)
                    .font(.custom("Lato-Bold", size: 16))
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.customGrey)
            }
            
                Image(difficulty.image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 15).stroke(.customBrown, lineWidth: 2).fill(.customWhite)
                .shadow(color: .shadow.opacity(0.2), radius: 12, y: -2)
        }
    }
}
