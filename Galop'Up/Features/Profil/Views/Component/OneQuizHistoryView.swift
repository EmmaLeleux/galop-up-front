//
//  OneQuizHistoryView.swift
//  Galop'Up
//
//  Created by Emma on 14/11/2026.
//

import SwiftUI

struct OneQuizHistoryView: View {
    var quizSessionHistory: QuizSessionHistory
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("\(quizSessionHistory.quiz.rawValue) : \(quizSessionHistory.niveauGalop?.rawValue ?? quizSessionHistory.difficulty.rawValue)")
                    .font(.custom("Lato-Bold", size: 15))
                
                HStack(alignment: .center){
                    Image(.horlogeIcon)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 18)
                    Text("\(quizSessionHistory.createdAt.relativeDisplayString)")
                        .font(.custom("Lato-Regular", size: 12))
                        .foregroundStyle(.customGrey)
                }
            }
            .foregroundStyle(.darkBrown)
            
            Spacer()
            
            VStack(spacing:2){
                Text("Score :")
                    .font(.custom("Lato-Regular", size: 13))
                Text("\(quizSessionHistory.nbGoodAnswer) / \(quizSessionHistory.nbQuestion)")
                    .font(.custom("Nunito", size: 18))
                    .fontWeight(.bold)
                
                if let chrono = quizSessionHistory.chrono{
                    HStack{
                        Image(.horlogeIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 12, height: 12)
                            
                        
                        Text(Duration.seconds(chrono).formatted(.time(pattern: .minuteSecond)))
                            .font(.custom("Lato-Regular", size: 12))
                    }
                }
            }
            .foregroundStyle(.customBrown)
            .padding(5)
            .padding(.horizontal)
            .background(RoundedRectangle(cornerRadius: 10).fill(.orangeButton.opacity(0.15)))
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(.customWhite).shadow(color: .darkBrown.opacity(0.1) ,radius: 3))
    }
}
