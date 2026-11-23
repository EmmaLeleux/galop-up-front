//
//  Lesson.swift
//  Galop'Up
//
//  Created by Emma on 22/11/2026.
//

import Foundation

struct Lesson: Codable, Identifiable, Hashable {
    let id : UUID
    let name: String
    let description: String
    let level: LevelGalopLessonQuizEnum
    let picture: Picture
    let content: String
    let isLikeByMe: Bool
    
}
