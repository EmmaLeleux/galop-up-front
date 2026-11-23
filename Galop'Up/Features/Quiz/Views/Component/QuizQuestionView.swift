//
//  QuizQuestionView.swift
//  Galop'Up
//
//  Created by Emma on 28/10/2026.
//

import SwiftUI

struct QuizQuestionView: View {
    let question: Question
    @Binding var playQuizVM: PlayQuizViewModel
    @Environment(QuizSessionViewModel.self) var quizVM
    
    var body: some View {
        VStack(spacing: 15){
            Text(question.question)
                .font(.custom("Nunito", size: 20))
                .foregroundStyle(.customBrown)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .minimumScaleFactor(0.85)
                .frame(maxWidth: .infinity)
                .frame(height: 84)
            
            HStack{
                Text(question.difficulty.rawValue)
                    .font(.custom("Lato-Regular", size: 14))
                    .foregroundStyle(.darkBrown)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.orangeButton.opacity(0.2))
                    .cornerRadius(8)
                
                Text(question.theme.name)
                    .font(.custom("Lato-Regular", size: 14))
                    .foregroundStyle(.darkBrown)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.orangeButton.opacity(0.2))
                    .cornerRadius(8)
                
            }
            
            if let picture = question.picture {
                Color.clear
                    .frame(maxWidth: .infinity)
                    .frame(height: 180)
                    .overlay {
                        AsyncImage(url: URL(string: picture.url)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
            }
            
            ForEach(question.answers, id: \.self){ answer in
                
                Button(action:{
                    playQuizVM.selectedAnswer = answer
                }, label: {
                    AnswerView(answer: answer, color: playQuizVM.fillAnswerColor(answer: answer, isCorrect: quizVM.isCorrect))
                    
                })
                
            }
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 15).stroke(.customBrown, lineWidth: 2).fill(.backgroundQuestion)
                .shadow(color: .shadow.opacity(0.2), radius: 10, y: -2)
        }
    }
}

