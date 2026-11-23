//
//  OnBoardingChoiceLevelView.swift
//  Galop'Up
//
//  Created by Emma on 23/11/2026.
//

import SwiftUI

struct OnBoardingChoiceLevelView: View {
    var onComplete: () -> Void
    @Environment(AuthViewModel.self) var authVM
    
    var body: some View {
        
        VStack{
            ForEach(LevelGalopUserEnum.allCases, id: \.self){ level in
                
                Button(action: {
                    Task{
                        try await authVM.updateUser(userInfos: UserInfoToUpdate(level: level))
                        
                    }
                }, label: {
                    HStack(spacing: 10){
                        Image(level.image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 60)
                        
                        Text(level.rawValue)
                            .font(.custom("Nunito", size: 16))
                            .fontWeight(.bold)
                            .foregroundStyle(.darkBrown)
                    }
                })
            }
        }
        
    }
}
