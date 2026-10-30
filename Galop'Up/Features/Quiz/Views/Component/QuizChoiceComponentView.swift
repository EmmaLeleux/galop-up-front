//
//  QuizChoiceComponentView.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import SwiftUI

struct QuizChoiceComponentView: View {
    var quiz: TypeQuizEnum
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text(quiz.rawValue)
                    .font(.custom("Nunito", size: 24))
                    .fontWeight(.bold)
                
                Text(quiz.description)
                    .font(.custom("Lato-Bold", size: 16))
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image(quiz.image)
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

