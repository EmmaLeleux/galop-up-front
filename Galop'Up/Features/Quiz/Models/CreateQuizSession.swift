//
//  CreateQuizSession.swift
//  Galop'Up
//
//  Created by Emma on 28/10/2026.
//

struct CreateQuizSession: Codable{
    let quiz: TypeQuizEnum
    let difficulty: QuizSessionDifficultyEnum
    let niveauGalop: LevelGalopLessonQuizEnum?
    
    init(quiz: TypeQuizEnum, difficulty: QuizSessionDifficultyEnum, niveauGalop: LevelGalopLessonQuizEnum? = nil) {
            self.quiz = quiz
            self.difficulty = difficulty
            self.niveauGalop = niveauGalop
        }
}
