//
//  CreatePostDTO.swift
//  Galop'Up
//
//  Created by Emma on 21/09/2026.
//

import Foundation

struct CreatePostRequest {
    let title: String
    let content: String
    let pictures: [Data]
}
