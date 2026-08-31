//
//  OnBoardingPageEnum.swift
//  Galop'Up
//
//  Created by Emma on 03/06/2026.
//

enum OnBoardingPageEnum: String, Identifiable, CaseIterable {
    case pageUsername
    case pageProfilPicture
    case pageLevel
    case beginner
    case notBeginner
    

    var id: String { rawValue }
    static var first: Self = .pageUsername
}
