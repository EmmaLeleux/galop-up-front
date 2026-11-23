//
//  ProfilView.swift
//  Galop'Up
//
//  Created by Emma on 01/10/2026.
//

import SwiftUI

struct ProfilView: View {
    @Environment(AuthViewModel.self) var authVM
    @Environment(QuizSessionViewModel.self) var quizVM
    @State var listQuizHistory: [QuizSessionHistory] = []
    var body: some View {
        if let user = authVM.currentUser{
            ZStack{
                Color.orangeBackground.ignoresSafeArea()
                ScrollView{
                    HStack(spacing: 50){
                        ProfilPictureComponentView(pictureUser: user.picture, size: 100)
                        
                        VStack(alignment: .center){
                            Text(user.username ?? "")
                                .font(.custom("DeliciousHandrawn-Regular", size: 40))
                                .foregroundStyle(.customBrown)

                            
                            Button(action: {
                                Task{
                                    try await authVM.logout()
                                }
                            }, label: {
                                
                                HStack{
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                    Text("Déconnexion")
                                }
                                    .CustomButton(width: 200)
                            })
                        }
                        
                        
                    }
                    .padding(.bottom, 50)
                    
                    HStack{
                        Text("Mes quiz récents")
                            .font(.custom("Nunito", size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.customBrown)
                        
                        Rectangle().frame(height: 1)
                            .foregroundStyle(.customBrown.opacity(0.7))
                    }
                    
                    ForEach(listQuizHistory, id: \.self){ quiz in
                        OneQuizHistoryView(quizSessionHistory: quiz)
                    }
                    
                }
                .padding(.horizontal)
                .onAppear {
                    Task{
                        listQuizHistory = try await quizVM.getHistoryQuizSession()
                    }
                }
            }
        }
        
    }
}

