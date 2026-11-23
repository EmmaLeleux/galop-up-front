//
//  StopQuizPopUp.swift
//  Galop'Up
//
//  Created by Emma on 03/11/2026.
//

import SwiftUI

struct StopQuizPopUp: View {
    @Binding var playQuizVM: PlayQuizViewModel
    @Environment(QuizSessionViewModel.self) var quizVM
    
    
    var body: some View {
        ZStack{
            Color.darkBrown.opacity(0.5)
                .ignoresSafeArea()
            
            VStack(spacing: 30){
                Text("Souhaitez-vous quitter le quiz en cours ? Votre progression sera perdue.")
                    .font(.custom("Lato-Bold", size: 20))
                    .foregroundStyle(.customBrown)
                
                HStack{
                    Spacer()
                    
                    Button(action: {
                        playQuizVM.openPopup.toggle()
                    }, label: {
                        Text("Reprendre")
                            .font(.custom("Nunito", size: 15))
                            .foregroundStyle(.customBrown)
                            .CustomButton()
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        Task{
                            await quizVM.stopQuizSession()
                        }
                    }, label: {
                        Text("Quitter")
                            .font(.custom("Nunito", size: 15))
                            .foregroundStyle(.customWhite)
                            .CustomButton(backgroundColor: .customGrey)
                    })
                    Spacer()
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 20).fill(.orangeBackground))
            .padding()
        }
    }
}


