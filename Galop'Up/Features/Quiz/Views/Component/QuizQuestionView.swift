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
    
    var body: some View {
        VStack(spacing: 15){
            Text(question.question)
                .font(.custom("Nunito", size: 20))
                .foregroundStyle(.customBrown)
                .fontWeight(.bold)
            
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
                GeometryReader{ geo in
                    AsyncImage(url: URL(string: picture.url)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geo.size.width, height: geo.size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    
                }
                
            }
            
            ForEach(question.answers, id: \.self){ answer in
                
                Button(action:{
                    playQuizVM.selectedAnswer = answer
                }, label: {
                    AnswerView(answer: answer, isSelected: playQuizVM.selectedAnswer == answer)

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

