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
                
                ProgressQuizView( playQuizVM: $playQuizVM)
                
                
                Spacer()
                if let question = quizVM.currentQuestion{
                    QuizQuestionView(question: question, playQuizVM: $playQuizVM)
                        .id(question.id)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing).combined(with: .opacity),
                            removal: .move(edge: .leading).combined(with: .opacity)
                        ))
                }
                
                Spacer()
                
                Button(action: {
                    if let answer = playQuizVM.selectedAnswer{
                        Task {
                            let updateSession: QuizSessionStart = try await quizVM.updateQuizSession(answer: answer)
                            playQuizVM.isRevealing = true
                            try? await Task.sleep(for: .seconds(1))
                            
                            withAnimation(.easeInOut(duration: 0.3)) {
                                quizVM.changeQuestion(quizSession: updateSession)
                            }
                            playQuizVM.isRevealing = false
                            playQuizVM.selectedAnswer = nil
                            
                        }
                    }
                }, label: {
                    Text("Valider")
                        .CustomButton(backgroundColor: playQuizVM.selectedAnswer != nil ? .orangeButton : .gray)
                })
                
                
                Spacer()
                
                
            }
            .padding()
            
            if playQuizVM.openPopup{
                VStack{
                    StopQuizPopUp(playQuizVM: $playQuizVM)
                }
            }
        }
    }
}
