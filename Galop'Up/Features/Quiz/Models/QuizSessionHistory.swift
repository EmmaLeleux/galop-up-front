//
//  QuizSessionHistory.swift
//  Galop'Up
//
//  Created by Emma on 14/11/2026.
//

import Foundation

struct QuizSessionHistory: Codable, Identifiable, Hashable {
    var id: UUID
    var difficulty: QuizSessionDifficultyEnum
    var niveauGalop: LevelGalopLessonQuizEnum?
    var createdAt: Date
    var chrono: Double?
    var nbQuestion: Int
    var nbGoodAnswer: Int
    var quiz: TypeQuizEnum
    
}
