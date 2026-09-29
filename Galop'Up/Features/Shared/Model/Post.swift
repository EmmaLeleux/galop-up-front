//
//  Post.swift
//  Galop'Up
//
//  Created by Emma on 31/08/2026.
//

import Foundation

struct Post: Codable, Identifiable {
    let id : UUID
    let title : String
    let content: String
    let pictures: [Picture]
    let author: User
    let createdAt: Date
    var likes: [User]
    var isLikeByMe: Bool
    
}


