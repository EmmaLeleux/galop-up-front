//
//  ResultQuizView.swift
//  Galop'Up
//
//  Created by Emma on 30/10/2026.
//

import SwiftUI

struct ResultQuizView: View {
    @Environment(QuizSessionViewModel.self) var quizVM
    
    var body: some View {
        VStack{
            
            Image(.galopinHeureux)
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            
            Text("Ton score est de")
                .font(.custom("Nunito", size: 25))
                .foregroundStyle(.customBrown)
            if let session = quizVM.activeSession {
                
                Text("\(session.nbGoodAnswer.description) / \(session.nbQuestion.description)")
                    .font(.custom("Nunito", size: 60))
                    .bold()
                    .foregroundStyle(.customBrown)
            }
            
            Button(action: {
                if let quiz = quizVM.activeSession{
                    Task{
                        try await quizVM.createQuizSession(quizSession: CreateQuizSession(quiz: quiz.quiz, difficulty: quiz.difficulty, niveauGalop: quiz.niveauGalop))
                    }
                    
                }
                
            }, label: {
                Text("Recommencer")
                    .CustomButton()
            })
            
            Button("Retour à l'acceuil") {
                quizVM.activeSession = nil
                quizVM.currentQuestion = nil
            }
            .foregroundStyle(.customBrown)
        }
        .padding()
        
    }
}
