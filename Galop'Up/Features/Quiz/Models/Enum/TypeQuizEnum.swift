//
//  TypeQuizEnum.swift
//  Galop'Up
//
//  Created by Emma on 29/09/2026.
//

import SwiftUI

enum TypeQuizEnum: String, CaseIterable, Codable {
    case CLASSIQUE = "Classique"
    case CONTRE_LA_MONTRE = "Contre la montre"
    case SURVIE = "Survie"
    
    var image : ImageResource {
        switch self {
        case .CLASSIQUE:
            return .galopinHeureux
        case .CONTRE_LA_MONTRE:
            return .galopinHeureux
        case .SURVIE:
            return .galopinHeureux
        }
    }
    
    var description: String {
        switch self {
        case .CLASSIQUE:
            return "Obtient un maximum de bonne réponse sur une série de 20 questions. Pas de temps imparti."
        case .CONTRE_LA_MONTRE:
            return "Répond à un maximum de question dans le temps imparti !"
        case .SURVIE:
            return "Démarre avec 3 vies et tente de survivre le plus longtemps possible sans erreur."
        }
    }
}
