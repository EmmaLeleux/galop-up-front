//
//  OnBoardingPageEnum.swift
//  Galop'Up
//
//  Created by Emma on 03/06/2026.
//

enum OnBoardingPageEnum: String, Identifiable, CaseIterable {
    case page1
    case page2
    

    var id: String { rawValue }
    static var first: Self = .page1
}
