//
//  UserInfoToUpdate.swift
//  Galop'Up
//
//  Created by Emma on 08/06/2026.
//

import Foundation

struct UserInfoToUpdate: Codable{
    var username: String?
    var picture: Data?
    var pictureInBase: UUID?
    var level: LevelGalopUserEnum?
}
