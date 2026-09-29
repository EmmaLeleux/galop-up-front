//
//  DashboardQuizView.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import SwiftUI

struct DashboardQuizView: View {
    @Environment(QuizService.self) var quizService
    
    var body: some View {
        VStack{
            ForEach(quizService.quizzes, id: \.self){ quiz in
                
                QuizChoiceComponentView(quiz: quiz)
            }
        }
        .onAppear{
            Task{
                try await quizService.fetchQuizzes()
            }
        }
    }
}
