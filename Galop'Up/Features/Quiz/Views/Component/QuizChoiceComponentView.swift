//
//  QuizChoiceComponentView.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import SwiftUI

struct QuizChoiceComponentView: View {
    var quiz: Quiz
    var body: some View {
        HStack{
            VStack{
                Text(quiz.type.rawValue)
                
                Text(quiz.description)
            }
            
            AsyncImage(url: URL(string: quiz.picture.url)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
        }
    }
}

