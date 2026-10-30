//
//  DifficultyChoiceView.swift
//  Galop'Up
//
//  Created by Emma on 29/09/2026.
//

import SwiftUI

struct GalopChoiceView: View {
    var quiz: TypeQuizEnum
    var difficulty: QuizSessionDifficultyEnum
    @Environment(QuizSessionViewModel.self) var quizVM
    var body: some View {
        ZStack{
            Color.orangeBackground.ignoresSafeArea()
            
            VStack(spacing: 20){
                Text("Quel galop souhaites-tu réviser ?")
                    .font(.custom("Nunito", size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(.darkBrown)
                    .padding(.bottom, 15)
                
                ForEach(LevelGalopLessonQuizEnum.allCases, id: \.self){ level in
                    Button(action:{
                        Task{
                            try await quizVM.createQuizSession(quizSession: CreateQuizSession(quiz: quiz, difficulty: difficulty, niveauGalop: level))
                        }
                    }, label: {
                        HStack(spacing: 10){
                            Image(level.image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 60)
                            
                            Text(level.rawValue)
                                .font(.custom("Nunito", size: 16))
                                .fontWeight(.bold)
                                .foregroundStyle(.darkBrown)
                        }
                    })
                    
                }
                
                
            }
        }
    }
}

