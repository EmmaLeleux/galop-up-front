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
                HStack{
                    Spacer()
                    NavigationLink(destination: ProfilView(), label: {
                        ProfilPictureComponentView(pictureUser: authVM.currentUser?.picture)
                    })
                    .padding(.trailing)
                }
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
