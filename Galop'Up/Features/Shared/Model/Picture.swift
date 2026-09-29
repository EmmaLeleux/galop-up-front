//
//  Picture.swift
//  Galop'Up
//
//  Created by Emma on 03/08/2026.
//

import Foundation

struct Picture : Codable, Identifiable, Hashable {
    let id: UUID
    let key: String
    let name: String
    let url: String
    let order: Int?
    let isDefault: Bool
}
