//
//  QuizSessionDifficultyEnum.swift
//  Galop'Up
//
//  Created by Emma on 27/10/2026.
//

import SwiftUI
enum QuizSessionDifficultyEnum: String, Codable, CaseIterable{
    case DEFINIE = "Définie"
    case CROISSANTE = "Croissante"
    case ALEATOIRE = "Aleatoire"
    case TUTO = "Tuto"
    
    var image : ImageResource {
        switch self {
        case .CROISSANTE:
            return .galopinHeureux
        case .ALEATOIRE:
            return .galopinHeureux
        case .DEFINIE:
            return .galopinHeureux
        case .TUTO:
            return .galopinHeureux
        }
    }
    
    var description: String {
        switch self {
        case .CROISSANTE:
            return "Tu démarres au Galop 1, puis chaque progrès te fait grimper d'un niveau. Jusqu'où iras-tu ?"
        case .ALEATOIRE:
            return "Les questions de tous les niveaux se mélangent. À toi de t'adapter !"
        case .DEFINIE:
            return "Tu choisis le Galop que tu veux réviser : toutes les questions seront de ce niveau."
        case .TUTO:
            return "Découvre le fonctionnement de l'application pas à pas, sans pression."
        }
    }
}
