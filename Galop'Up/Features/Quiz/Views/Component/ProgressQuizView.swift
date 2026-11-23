//
//  ProgressQuizView.swift
//  Galop'Up
//
//  Created by Emma on 02/11/2026.
//

import SwiftUI

struct ProgressQuizView: View {
    @Environment(QuizSessionViewModel.self) var quizVM
    
    @Binding var playQuizVM: PlayQuizViewModel
    
    
    var body: some View {
        if let session = quizVM.activeSession{
            if session.quiz == .CLASSIQUE{
                VStack{
                    HStack{
                        
                        StopQuizButton(playQuizVM: $playQuizVM)
                        
                        Spacer()
                    }
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
                }
            }
            
            else if session.quiz == .SURVIE{
                HStack{
                    StopQuizButton(playQuizVM: $playQuizVM)
                    
                    Spacer()
                    
                    ForEach(0..<playQuizVM.getNbLifes(nbQuestions: session.nbQuestion, nbCorrectAnswers: session.nbGoodAnswer), id: \.self){i in
                        Image(.heartFill)
                            .resizable()
                            .scaledToFit()
                    }
                }
                .frame(height: 25)
            }
            
            else if session.quiz == .CONTRE_LA_MONTRE{
                HStack {
                    StopQuizButton(playQuizVM: $playQuizVM)
                    Spacer()
                    
                    if let deadline = quizVM.deadline {
                        TimelineView(.periodic(from: .now, by: 0.5)) { context in
                            let remaining = deadline.timeIntervalSince(context.date)
                            Text("\(Int(remaining.rounded(.up)))")
                                .font(.custom("Nunito", size: 24))
                                .onChange(of: remaining <= 0) { _, finished in
                                    if finished {
                                        Task { await quizVM.finishQuizSession() }
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}
