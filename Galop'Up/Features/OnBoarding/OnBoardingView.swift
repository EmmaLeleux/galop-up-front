//
//  OnBoardingView.swift
//  Galop'Up
//
//  Created by Emma on 03/06/2026.
//

import SwiftUI

struct OnBoardingView: View {
    @Environment(AuthService.self) var authService
    @State var onBoardingVM = OnBoardingViewModel()
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing:0){
                ForEach(onBoardingVM.pages) { page in
                    switch page {
                    case .page1: OnBoardingPage1(onComplete: onBoardingVM.goToPage2)
                            .containerRelativeFrame([.horizontal])
                    case .page2: OnBoardingPage2(onComplete: authService.fetchUser)
                            .containerRelativeFrame([.horizontal])
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition($onBoardingVM.position)
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.hidden)
        .scrollDisabled(true)
        .onAppear {
            
            onBoardingVM.position.scrollTo(id: OnBoardingPageEnum.first.id)
            
        }
    }
}


#Preview {
    OnBoardingView().environment(AuthService())
}
