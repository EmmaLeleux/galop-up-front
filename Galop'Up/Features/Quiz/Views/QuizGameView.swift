//
//  QuizGameView.swift
//  Galop'Up
//
//  Created by Emma on 28/10/2026.
//

import SwiftUI

struct QuizGameView: View {
    @Environment(QuizSessionViewModel.self) var quizVM
    
    @State var playQuizVM: PlayQuizViewModel = PlayQuizViewModel()
    var body: some View {
        ZStack{
            Color.orangeBackground.ignoresSafeArea()
            
            VStack(spacing: 20){
                
                GeometryReader{geo in
                    ZStack{
                        HStack{
                            RoundedRectangle(cornerRadius: 20).fill(.orangeButton)
                                .frame(width: geo.size.width * playQuizVM.getProgressQuizClassique(nbQuestions: quizVM.activeSession?.nbQuestion ?? 0), height: 5)
                            Spacer()
                        }
                        RoundedRectangle(cornerRadius: 20).fill(.orangeButton.opacity(0.1))
                            .frame(width: geo.size.width, height: 5)
                        
                        
                    }
                }
                .frame(height: 5)
                
                Spacer()
                if let question = quizVM.currentQuestion{
                    QuizQuestionView(question: question, playQuizVM: $playQuizVM)
                }
                
                Spacer()
                
                Button(action: {
                    if let answer = playQuizVM.selectedAnswer{
                        Task{
                            try await quizVM.updateQuizSession(answer: answer)
                        }
                    }
                }, label: {
                    Text("Valider")
                        .CustomButton(backgroundColor: playQuizVM.selectedAnswer != nil ? .orangeButton : .gray)
                })
                
                
                Spacer()
                
                
            }
            .padding()
        }
    }
}
