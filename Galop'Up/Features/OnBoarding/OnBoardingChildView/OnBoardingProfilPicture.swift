//
//  OnBoardingProfilPicture.swift
//  Galop'Up
//
//  Created by Emma on 08/06/2026.
//

import SwiftUI

struct OnBoardingProfilPicture: View {
    @Environment(AuthService.self) var authService
    var onComplete: () -> Void
    
    var body: some View {
        VStack{
            ConversationComponentView(text: "Enchanté \(authService.currentUser?.username ?? "") ! Et si tu choisissais une photo de profil pour commencer ?")
            Image(.galopinHeureux)
                .resizable()
                .mascotteSize()
                .padding(.bottom, 15)
            
            
            Image(.profilPictureAnonyme)
            
            HStack{
                Image(.profilPictureAnonyme)
                    .resizable()
                    .scaledToFit()
                
                Image(.profilPictureAnonyme)
                    .resizable()
                    .scaledToFit()
                
                Image(.profilPictureAnonyme)
                    .resizable()
                    .scaledToFit()
                
                ZStack{
                    if let photo =  authService.currentUser?.picture{
                        AsyncImage(url: URL(string: photo)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(.circle)
                            
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Image(.iconAppareilPhoto)
                        .resizable()
                        .scaledToFit()
                        .padding(20)
                        .overlay(
                            
                            Circle()
                                .stroke(lineWidth: 1).foregroundStyle(.darkBrown)
                        )
                      
                }
            }
            .padding()
            
            Button("Suivant") {
                onComplete()
            }
            .CustomButton()
            
            Button("Passer") {
                onComplete()
            }
            .foregroundStyle(.customBrown)
        }
    }
}


