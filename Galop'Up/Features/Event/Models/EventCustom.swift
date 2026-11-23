//
//  EventCustom.swift
//  Galop'Up
//
//  Created by Emma on 07/11/2026.
//

import Foundation

struct EventCustom: Codable, Identifiable {
    let id : UUID
    let name: String
    let description: String
    let picture: Picture
    let startDate: Date
    let endDate: Date
    let deadline: Date?
    let placeName: String
    let address: String
    let latitude: Double
    let longitude: Double
    let price: Double?
    let capacity: Int?
    let levelMin: LevelGalopUserEnum?
    let levelMax: LevelGalopUserEnum?
    let equipment: String?
    let typeEvent: TypeEvent
    let author: UserPublic
    var isLikeByMe: Bool
    
}
