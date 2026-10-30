//
//  Question.swift
//  Galop'Up
//
//  Created by Emma on 28/10/2026.
//

import Foundation

struct Question: Codable, Identifiable {
    let id : UUID
    let question: String
    let type: TypeQuestionEnum
    let difficulty: LevelGalopLessonQuizEnum
    let status: StatusQuestionEnum
    let theme: ThemeQuestion
    let user: UserPublic
    let picture: Picture?
    let answers: [Answer]
    
}

