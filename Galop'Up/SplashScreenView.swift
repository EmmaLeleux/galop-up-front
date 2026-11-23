//
//  SplashScreenView.swift
//  Galop'Up
//
//  Created by Emma on 17/11/2026.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        ZStack {
            Color.orangeBackground
                .ignoresSafeArea()
            
            VStack{
                
                Image(.galopUpTitle)
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 30)
                
                Image(.galopinHeureux)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
            }
            
            
            
        }
    }
}

#Preview {
    SplashScreenView()
}
