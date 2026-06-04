//
//  OnBoardingViewModel.swift
//  Galop'Up
//
//  Created by Emma on 03/06/2026.
//

import Foundation
import SwiftUI

@Observable
class OnBoardingViewModel {
    
    var position: ScrollPosition = .init(idType: OnBoardingPageEnum.ID.self)
    let pages = OnBoardingPageEnum.allCases
    
    private func scrollToPage(_ page: OnBoardingPageEnum) {
        withAnimation {
            position.scrollTo(id: page.id)
        }
    }

    func goToPage2() { scrollToPage(.page2) }
    
    
}
