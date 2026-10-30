//
//  OnBoardingView.swift
//  Galop'Up
//
//  Created by Emma on 03/06/2026.
//

import SwiftUI

struct OnBoardingView: View {
    @Environment(AuthViewModel.self) var authVM
    @State var onBoardingVM = OnBoardingViewModel()
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing:0){
                ForEach(onBoardingVM.pages) { page in
                    switch page {
                    case .pageUsername: OnBoardingUsername(onComplete: onBoardingVM.goToPageProfilPicture)
                            .padding(.horizontal)
                            .containerRelativeFrame([.horizontal])
                        
                    case .pageProfilPicture: OnBoardingProfilPicture(onComplete: onBoardingVM.goToPageLevel )
                            .padding(.horizontal)
                            .containerRelativeFrame([.horizontal])
                        
                    case .pageLevel: OnBoardingLevelView(onCompleteBeginner: onBoardingVM.goToPageBeginnerLevel, onCompleteNotBeginner: onBoardingVM.goToPageLevelNotBeginner )
                            .padding(.horizontal)
                            .containerRelativeFrame([.horizontal])
                        
                    case .beginner: OnBoardingLevelBeginnerView(onComplete: {Task{
                        authVM.fetchUser
                    }
                    })
                    .padding(.horizontal)
                    .containerRelativeFrame([.horizontal])
                        
                    case .notBeginner: OnBoardingLevelBeginnerView(onComplete: {Task{
                        authVM.fetchUser
                    }
                    })
                    .padding(.horizontal)
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

