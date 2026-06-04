//
//  User.swift
//  Galop'Up
//
//  Created by Emma on 21/05/2026.
//

import Foundation

struct User: Codable, Identifiable {
    let id : UUID
    let username : String?
    let email: String
    let age: Int?
    let googleId: String?
    let appleId: String?
    let level: LevelGalopUserEnum?
    let picture: String?
    let role: UserRoleEnum
    let isBanned: Bool
    let deletedAt: Date?
}
