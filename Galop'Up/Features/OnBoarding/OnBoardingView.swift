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
    @State var userService: UserService = UserService()
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
                        
                    case .pageLevel: OnBoardingLevelView(onComplete: {
                        Task{
                            authService.fetchUser
                        }
                    } )
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
        .environment(userService)
        .onAppear {
        
                onBoardingVM.position.scrollTo(id: OnBoardingPageEnum.first.id)
                userService.setAuthService(authService)
            
            
            
        }
    }
}


#Preview {
    OnBoardingView().environment(AuthService())
}
