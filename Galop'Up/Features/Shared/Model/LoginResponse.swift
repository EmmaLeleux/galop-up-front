//
//  LoginResponse.swift
//  Galop'Up
//
//  Created by Emma on 21/05/2026.
//

import Foundation

struct LoginResponse: Codable {
    let accessTokenExpiration: Date
    let accessToken: String
    let refreshToken: String
}
