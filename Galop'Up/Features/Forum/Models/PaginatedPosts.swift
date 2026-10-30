//
//  PaginatedPost.swift
//  Galop'Up
//
//  Created by Emma on 13/09/2026.
//

struct PaginatedPosts: Codable {
    let posts: [Post]
    let nextCursor: String?
}
