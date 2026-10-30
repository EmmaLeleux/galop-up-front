//
//  DifficultyChoiceView.swift
//  Galop'Up
//
//  Created by Emma on 27/10/2026.
//

import SwiftUI

struct DifficultyChoiceView: View {
    var quiz: TypeQuizEnum
    @Environment(QuizSessionViewModel.self) var quizVM
    
    var body: some View {
        ZStack{
            Color.orangeBackground.ignoresSafeArea()
            
            VStack(spacing: 20){
                Text("Quelle difficulté souhaitez-vous jouer ?")
                    .font(.custom("Nunito", size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.darkBrown)
                    .padding(.bottom, 15)
                
                ForEach(QuizSessionDifficultyEnum.allCases, id: \.self){ difficulty in
                    
                    if difficulty != .TUTO{
                        if difficulty == .DEFINIE{
                            NavigationLink(destination: {
                                GalopChoiceView(quiz: quiz, difficulty: difficulty)
                            }, label: {
                                OneDifficultyChoiceComponentView(difficulty: difficulty)
                                
                            })
                        }
                        
                        else{
                            Button(action:{
                                Task{
                                    try await quizVM.createQuizSession(quizSession: CreateQuizSession(quiz: quiz, difficulty: difficulty))
                                }
                            }, label: {
                                OneDifficultyChoiceComponentView(difficulty: difficulty)
                            })
                        }
                        
                    }
                    
                }
                
            }
            .padding(.horizontal)
        }
    }
}
