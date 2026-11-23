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
            return "Tu réponds à une série de 20 questions et tu essaies d'obtenir un maximum de bonnes réponses. Pas de temps imparti."
        case .CONTRE_LA_MONTRE:
            return "Tu as 60 secondes pour répondre à un maximum de questions !"
        case .SURVIE:
            return "Tu démarres avec 3 vies : chaque erreur t'en fait perdre une. Tiens le plus longtemps possible !"
        }
    }
}
