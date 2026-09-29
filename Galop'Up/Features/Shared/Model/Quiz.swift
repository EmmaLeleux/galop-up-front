//
//  Quiz.swift
//  Galop'Up
//
//  Created by Emma on 28/09/2026.
//

import Foundation

struct Quiz: Codable, Identifiable, Hashable {
    let id : UUID
    let type: TypeQuizEnum
    let picture: Picture
    let description: String
    
}
