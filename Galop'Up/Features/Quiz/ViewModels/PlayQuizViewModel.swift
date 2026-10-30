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
    
    func getProgressQuizClassique(nbQuestions: Int ) -> CGFloat{
        if nbQuestions == 0 {
            return 0
        }
        
        else if nbQuestions >= 20{
            return 1
        }
        else {
            return CGFloat(nbQuestions / 20)
        }
    }
    
    
}
