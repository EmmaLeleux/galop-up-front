//
//  LevelGalopQuizEnum.swift
//  Galop'Up
//
//  Created by Emma on 29/09/2026.
//

import SwiftUI
enum LevelGalopLessonQuizEnum: String, Codable, CaseIterable{
    case GALOP1 = "Galop 1"
    case GALOP2 = "Galop 2"
    case GALOP3 = "Galop 3"
    case GALOP4 = "Galop 4"
    case GALOP5 = "Galop 5"
    case GALOP6 = "Galop 6"
    case GALOP7 = "Galop 7"
    case CULTURE = "Culture"
    
    var image : ImageResource {
        switch self {
        case .GALOP1:
            return .galopinHeureux
        case .GALOP2:
            return .galopinHeureux
        case .GALOP3:
            return .galopinHeureux
        case .GALOP4:
            return .galopinHeureux
        case .GALOP5:
            return .galopinHeureux
        case .GALOP6:
            return .galopinHeureux
        case .GALOP7:
            return .galopinHeureux
        case .CULTURE:
            return .galopinHeureux
        }
    }
}
