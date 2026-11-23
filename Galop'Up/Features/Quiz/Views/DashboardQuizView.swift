//
//  DashboardQuizView.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import SwiftUI

struct DashboardQuizView: View {
    @Environment(AuthViewModel.self) var authVM

    var body: some View {
        ZStack{
            Color.orangeBackground.ignoresSafeArea()
            VStack(spacing: 20){
                HeaderView(title: "Quiz", description: "Teste tes connaissances et prépare tes Galops en t'amusant !")

                ForEach(TypeQuizEnum.allCases, id: \.self){ quiz in
                    
                    NavigationLink(
                        destination: DifficultyChoiceView(quiz: quiz),
                        label: {QuizChoiceComponentView(quiz: quiz)}
                    )
                    
                }
            }
            .padding(.horizontal)
        }
    }
}
