//
//  AnswerView.swift
//  Galop'Up
//
//  Created by Emma on 29/10/2026.
//

import SwiftUI

struct AnswerView: View {
    var answer: Answer
    var isSelected: Bool
    var body: some View {
        HStack{
            Text(answer.description)
                .font(.custom("Lato-Regular", size: 16))
                .foregroundStyle(.darkBrown)
            Spacer()
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 10).stroke(.customBrown, lineWidth: 2).fill(isSelected ? .orangeButton.opacity(0.6): .customWhite)
                .shadow(color: .shadow.opacity(0.2), radius: 5, y: 1)
        }
    }
}

