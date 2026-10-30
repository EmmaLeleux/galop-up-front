//
//  UserPublic.swift
//  Galop'Up
//
//  Created by Emma on 18/10/2026.
//

import Foundation

struct UserPublic: Codable, Identifiable {
    let id : UUID
    let username : String?
    let picture: Picture?
}
