//
//  Quiz.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import Foundation

struct QuizSession: Codable, Identifiable {
    let id : UUID
    let difficulty: QuizSessionDifficultyEnum
    let niveauGalop: LevelGalopLessonQuizEnum?
    let createdAt: Date
    let chrono: Double?
    let nbQuestion: Int
    let nbGoodAnswer: Int
    let remainingSeconds: Double?
    let quiz: TypeQuizEnum
    let user: UserPublic
    
}

