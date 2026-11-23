//
//  OneAnswerViewModel.swift
//  Galop'Up
//
//  Created by Emma on 29/10/2026.
//

import Foundation
import SwiftUI

@Observable
class PlayQuizViewModel{
    
    var selectedAnswer: Answer? = nil
    var openPopup: Bool = false
    var isRevealing: Bool = false
    
    func getProgressQuizClassique(nbQuestions: Int ) -> CGFloat{
        if nbQuestions == 0 {
            return 0
        }
        
        else if nbQuestions >= 20{
            return 1
        }
        else {
            return CGFloat(nbQuestions) / 20
        }
    }
    
    func getNbLifes(nbQuestions: Int, nbCorrectAnswers: Int) -> Int{
        
        if nbQuestions == 0 {
            return 3
        }
        else if nbCorrectAnswers == nbQuestions{
            return 3
        }
        else {
            let nbWrongAnswer = nbQuestions - nbCorrectAnswers
            
            return max(0, 3 - nbWrongAnswer)
            
        }
    }
    
    func fillAnswerColor(answer: Answer, isCorrect: Bool?) -> Color {
        let isSelected = selectedAnswer == answer

        guard isRevealing else {
            return isSelected ? .orangeButton.opacity(0.6) : .customWhite
        }
        if let isCorrect = isCorrect, isSelected{
            return isCorrect ? .customGreen : .customRed
        }
        return .customWhite
    }
    
    
}
